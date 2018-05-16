VinsolSpreeThemes
==================

This extension allows the admin to upload new spree store themes from backend. This extension provides an interface where admin can manage all the themes by editing them, deleting old themes and publishing theme to store for the users.

Admin can even preview the theme after modifying it from the backend before publishing it to the users.

Try Spree Themes for Spree 3-4 with direct deployment on Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/vinsol-spree-contrib/spree-demo-heroku/tree/spree-themes-new)


### Steps to Publish a Theme.
Go to - https://github.com/vinsol-spree-contrib/spree_themes/wiki/Steps-to-Publish-a-Theme


### Download Sample Themes:

For SPREE 3.2

https://github.com/vinsol-spree-contrib/theme-BigShop/archive/3-2-stable.zip

https://github.com/vinsol-spree-contrib/theme-ClassicWhite/archive/3-2-stable.zip

https://github.com/vinsol-spree-contrib/theme-OnlineStore/archive/3-2-stable.zip

https://github.com/vinsol-spree-contrib/theme-CrownTheme/archive/3-2-stable.zip

https://github.com/vinsol-spree-contrib/theme-LatticeTheme/archive/3-2-stable.zip

https://github.com/vinsol-spree-contrib/theme-Matrix/archive/3-2-stable.zip

https://github.com/vinsol-spree-contrib/theme-Unite/archive/3-2-stable.zip

https://github.com/vinsol-spree-contrib/theme-CrownTheme-2/archive/3-2-stable.zip




For SPREE 3.3 and SPREE 3.4

https://github.com/vinsol-spree-contrib/theme-BigShop/archive/3-3-bump.zip

https://github.com/vinsol-spree-contrib/theme-ClassicWhite/archive/3-3-bump.zip

https://github.com/vinsol-spree-contrib/theme-OnlineStore/archive/3-3-bump.zip

https://github.com/vinsol-spree-contrib/theme-CrownTheme/archive/3-3-bump.zip

https://github.com/vinsol-spree-contrib/theme-LatticeTheme/archive/3-3-bump.zip

https://github.com/vinsol-spree-contrib/theme-Matrix/archive/3-3-bump.zip

https://github.com/vinsol-spree-contrib/theme-Unite/archive/3-3-bump.zip

https://github.com/vinsol-spree-contrib/theme-CrownTheme-2/archive/3-3-bump.zip



## Requirements

This extension currently supports Ruby 2.4.2, Rails 5.1 and Spree 3.4.


## Features

Some of the current functionalities are:-

1. Upload the theme
1. Preview the theme.
2. Publish the theme on spree store.
3. Download the theme.
4. Remove the uploaded theme.
5. Modify the uploaded / published theme.


## Installation

1. Add this extension to your Gemfile:

For SPREE 3.4

  ```ruby
  gem 'vinsol_spree_themes', github: 'vinsol-spree-contrib/spree_themes', branch: 'master'
  ```

For SPREE 3.3

  ```ruby
  gem 'vinsol_spree_themes', github: 'vinsol-spree-contrib/spree_themes', branch: '3-3-stable'
  ```

For SPREE 3.2

  ```ruby
  gem 'vinsol_spree_themes', github: 'vinsol-spree-contrib/spree_themes', branch: '3-2-stable'
  ```

  *Note:- Add this gem at the end of your gemfile as it has some sprocket-rails dependency and needs to be loaded after all gems are loaded.*

2. Also add the following gem above the extension:
   ```ruby
   gem 'sprockets-helpers', '~> 1.2.1'
   ```

   *Note:- This gem is dependent for the preview feature.*

3. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

4. Copy & run migrations
  ```ruby
  bundle exec rails g vinsol_spree_themes:install
  ```

5. Restart your server
  ```ruby
  rails server
  ```


## Usage

# Development

Make sure to set the following config in environment file `development.rb`.

`config.assets.debug = false`


After installing the extension, admin will see a tab `vinsol spree themes` on left sidebar of admin panel. Or you can visit the link

```
 http://localhost:3000/admin/themes
```

Then, admin uploads the new theme in zip file(Download sample themes from the links added below). Once uploaded, admin can preview the theme and also modify it accordingly through the editor.

Theme templates can be modified through the editor. Later theme can be published for the spree store users.

*Note:- Before publishing the theme, admin needs to compile it using the link provided with other options for all assets to load properly.*

Once the extension is installed, admin gets a spree store default theme uploaded on the system and is published for the store users.

Besides preview and publishing, admin can delete the uploaded theme or download it in zip format.


## Themes

Some spree store themes can be cloned from the following link:-

1. https://github.com/vinsol-spree-contrib/theme-ClassicWhite.git
2. https://github.com/vinsol-spree-contrib/theme-BigShop.git

After clonning, zip the files of the theme and upload the zip file from the admin interface.

Yay!! new theme is ready to be published.


## Theme Structure

Theme file structure for the zip file to be uploaded:-

* Theme.zip
  * javascripts
  * stylesheets
  * images
  * views: These views will be the spree frontend view directory.
  * snapshot.png: This is the snapshot for the theme visible at backend.
  * meta_info.yml: This .yml file contains meta info of the theme.

*Note:- When uploading, files starting with '__' or '.' will be ignored*

Create a meta_info.yml file on the theme directory which contains the meta info of the theme. Format of the file should be following:-
 * name: Name of the theme
 * version: Version of the theme
 * authors: Authors of the theme

*Note:- Add new javascript files to javascripts directory and new stylesheet files to stylesheets directory. For adding js and css manifest files, file name should be script.manifest.js or style.manifest.css. If using sass, use style.manifest.scss files instead of .css.*


## Developers

If you wish to modify the theme directly from the filesystem, follow these steps:-

1. Publish the theme which need to be updated/modified.

2. Update the theme assets, stylesheets, scripts and templates from the path.
  ```
  public/vinsol_spree_themes/<theme_name>/
  ```

  or

  ```
  public/vinsol_spree_themes/current/
  ```

3. If application is running, reload the store page and you will see the changes on the browser.

4. Once all the changes are done and final theme is ready, run the following rake task to sync the updated files with the database.
  ```
  bundle exec rake db:sync_templates THEME_NAME=<theme_name>
  ```


## Downloading Theme

Admin can download the theme in the zip format after modifying it. While uploading the downloaded theme, admin needs to follow the below steps:-

1. Make sure to change the theme name (Theme name is the name of the zip file).

2. Make sure to update the meta info of the theme in the file `meta_info.yml` when the theme is updated.

3. Extract the downloaded zip file and then need to compress the files within the extracted folder. Otherwise, the theme structure will change and there will be issue while uploading.



## Production Setup

1. Set the following configuration for production environment in environment file `production.rb`:
  ```ruby
  config.assets.compile = true
  config.public_file_server.enabled = true
  ```

2. Also, set the assets compressors in `production.rb` file.
  ```ruby
  config.assets.js_compressor = :uglifier 
  config.assets.css_compressor = :sass
  ```

3. For Capistrano: Add the following path to the shared linked dir in deploy.rb file.
  ```
  set :linked_dirs, %w( public/vinsol_spree_themes )
  ```


## Assumptions

While developing this extensions, we faced few issues related to assets precompilation, spree fragment caching and rails template caching. To resolve these issues we made few assumptions:

1. For clearing cache, we used rails resolvers. We are assuming that whenever the template is modified, we are clearing the cache.

2. When previewing the theme, we remove the cache directory under `tmp/cache` for proper theme rendering.

3. We are assuming the theme zip filename to be the theme name and admin cannot upload the other theme with the same name.

4. We need to compile and minify the assets before publishing the theme using the compile link for proper rendering of theme.

5. Rails app is using centeral cache store. So that Rails.cache.clear can flush cache for all application servers.


## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'vinsol_spree_themes/factories'
```


## RoadMaps

Some other features which need to work on and are under development:-

1. Theme revisions and rollback to previous theme versions.
2. Maintaining the themes in multiple instances / cluster mode.
3. Extension Dependencies for Spree < 3.2 and Rails 4.
4. Update theme images like scripts and styles from admin interface.
5. Flexibility to modify other spree extension views according to the theme.
6. Displaying Theme information using theme meta info.


## Contributing

If you'd like to contribute, please follow the below steps:-

1. Fork the repo.
2. Clone your repo.
3. Run bundle install.
4. Run bundle exec rake test_app to create the test application in spec/test_app.
5. Make your changes.
6. Ensure specs pass by running bundle exec rspec spec.
7. Submit your pull request.


Credits
-------

[![vinsol.com: Ruby on Rails, iOS and Android developers](http://vinsol.com/vin_logo.png "Ruby on Rails, iOS and Android developers")](http://vinsol.com)

Copyright (c) 2017 [vinsol.com](http://vinsol.com "Ruby on Rails, iOS and Android developers"), released under the New MIT License
