module MyGallery
  class GalleriesController < ApplicationController
    before_action :require_current_user!
    before_action :fetch_gallery
    before_action :redirect_if_no_images, only: %i[create update]

    def show;end

    def create
      gallery = Gallery.new(
        user: Current.user,
        images: gallery_params[:images]
      )

      return redirect_to root_url unless gallery.save

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: just_uploaded_images_turbo_streams(gallery)
        end
        format.html { redirect_to root_url }
      end
    end

    def update
      @gallery.images.attach(gallery_params[:images])

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: just_uploaded_images_turbo_streams(@gallery)
        end
        format.html { redirect_to root_url }
      end
    end

    def delete_image_attachment
      image = @gallery.images.blobs.find_signed(params[:id])
      if image
        attachment = image.attachments.first
        attachment.purge
      end
      respond_to do |format|
        format.turbo_stream do
          if image
            render turbo_stream: turbo_stream.remove(image.signed_id)
          end
        end
        format.html { redirect_to root_url }
      end
    end

    private

    def just_uploaded_images_turbo_streams(gallery)
      gallery_params[:images].map do |signed_id|
        ActiveStorage::Blob.find_signed(signed_id).attachments.first
      end.map do |image|
        turbo_stream.replace(
          image.signed_id,
          partial: 'my_gallery/galleries/image',
          locals: { image: image }
        )
      end
    end

    def redirect_if_no_images
      return redirect_to root_url if params[:gallery].blank?
    end

    def gallery_params
      params.require(:gallery).permit(images: [])
    end

    def fetch_gallery
      @gallery = Current.user.gallery || Gallery.new
    end
  end
end
