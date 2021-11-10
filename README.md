# README
This repo is to learn about
- [x] ActiveStorage
- [ ] Search with Elastic Search
- [ ] Authentication
- [ ] Mailer styling with Tailwind
- [ ] View Components

## TODO Elastic Search
- [x] Read [some ElasticSearch documentation](https://www.elastic.co/guide/index.html)
- [ ] Setup correctly security for xPack (Elastic products). Passowrd and users
- [ ] Setup Kibana with Docker compose
- [ ] Setup Rails app for using Elastic Search server with Elastic Ruby gems. Follow [this article](https://medium.com/wolox/from-zero-to-hero-multimodel-autocompletion-search-with-elasticsearch-rails-3beff17fa8c6)

## TODO ActiveStorage
- [x] Read [the docs](https://edgeguides.rubyonrails.org/active_storage_overview.html) enterelly
- [x] Do upload your avatar UI. Simple Rails ActiveStorage upload.
- [x] Setup TailwindCSS with ESBuild.
- [x] Create a `gallery` model related with `User` and add a `gallery.images` attachments.
- [x] Create images in gallery with direct upload
- [x] Upade images in gallery with direct upload
- [x] Make work [Direct upload](https://edgeguides.rubyonrails.org/active_storage_overview.html#direct-uploads)
- [x] Understand difference between [Redirect mode](https://edgeguides.rubyonrails.org/active_storage_overview.html#redirect-mode) and [Proxy mode](https://edgeguides.rubyonrails.org/active_storage_overview.html#proxy-mode)
- [x] Direct upload progress styles + replace with image
- [x] Turbo stream the file input as partial becuase after upload it gets `disabled`
- [x] Drag & drop files in the Dropable area. ~Use ActiveStorage in JS to send the files.~ It was not necessary, just seeting the files in the input=file
- [x] Show progress in the upload area.
- [ ] Do something when `direct-upload:error` event happens.
- [ ] Deploy to Heroku and host assets on S3 [Digital Ocean Spaces](https://docs.digitalocean.com/products/spaces/)
- [ ] Or try [Cloudinary](https://cloudinary.com/pricing) which is free and have a nice Rails gem integration.
- [ ] Understand how using a CDN works.

## TODO Authentication
Devise is the fastest way of get up and running. But it would be nice to have a basic setup
with all auth mambo jambo with plain [Rails securepassword](https://guides.rubyonrails.org/active_model_basics.html#securepassword).
- [] Follow [this article](https://www.section.io/engineering-education/how-to-setup-user-authentication-from-scratch-with-rails-6/)
     and their [code here](https://github.com/Njunu-sk/Rails-Authentication)

## TODO Mailer styles
Try to use [maizzle.com/](https://maizzle.com/). Maizzle is a framework that helps you quickly build HTML emails with
Tailwind CSS and advanced, email-specific post-processing.
- [ ] Integrate with Rails. [Looks possible](https://github.com/maizzle/framework/issues/346)

## TODO View components
- [] Setup [View components](https://github.com/github/view_component)
- [] Integrate with Rails
- [] Develop the flash message with a message component
- [] Read about Story book integration with view components
- [] Find inspiration in [GitHub Primer](https://github.com/primer/view_components)
