# CKEditor for rails asset pipeline

[CKEditor](http://ckeditor.com/) is a library for WYSIWYG editor to be used inside web pages.

The `ckeditor_rails` gem integrates the `CKEditor` with the Rails asset pipeline.

And it would work with following environments:

* ruby 1.9.3+
* rails 3.0+

## Basic Usage

### Install ckeditor_rails gem

Include `ckeditor_rails` in Gemefile

```ruby
gem 'ckeditor_rails'
```

Then run `bundle install`

### Include CKEditor javascript assets

Add to your `app/assets/javascripts/application.js` after `//= require jquery_ujs` to work with jQuery

``` javascript
//= require ckeditor-jquery
```

### Modify form field for CKEditor

Add `ckeditor` class to text area tag

``` ruby
<%= f.text_area :content, :class => 'ckeditor' %>
```

### Initialize CKEditor in Javascript file

``` javascript
$('.ckeditor').ckeditor({
  // optional config
});
```

### Deployment

Since version 4.1.3, non-digested assets of `ckeditor-rails` will simply be copied after digested assets were compiled.

Eric Anderson, thanks.

## Advanced Usage

### Include customized configuration javascript for CKEditor

Add your `app/assets/javascripts/ckeditor/config.js.coffee` like

``` coffee
CKEDITOR.editorConfig = (config) ->
  config.language = "zh"
  config.uiColor = "#AADC6E"
  true
```

Type `CKEDITOR.config` in browser's console panel to check all configuration.

Add your `config.js` to assets precompile list in `config/initializers/assets.rb`.

``` ruby
Rails.application.config.assets.precompile += %w( ckeditor/config.js )
```

### Include customized stylesheet for contents of CKEditor

Add your `app/assets/stylesheets/ckeditor/contents.css.scss` like

``` scss
body {
  font-size: 14px;
  color: gray;
  background-color: yellow;
}
ol,ul,dl {
  *margin-right:0px;
  padding:4 20px;
}
```

Add your `contents.css` to assets precompile list in `config/initializers/assets.rb`.

``` ruby
Rails.application.config.assets.precompile += %w( ckeditor/contents.css )
```

### Remove CKEditor addon services

To avoid see warnings like

``` js
ckeditor.source.js:21 [CKEDITOR] Error code: exportpdf-no-token-url.
ckeditor.source.js:21 [CKEDITOR] For more information about this error go to https://ckeditor.com/docs/ckeditor4/latest/guide/dev_errors.html#exportpdf-no-token-url
```

Edit your `app/assets/javascripts/ckeditor/config.js.coffee` like

``` coffee
CKEDITOR.editorConfig = (config) ->
  config.removePlugins = 'exportpdf'
  true
```

Ref: https://ckeditor.com/cke4/addon/exportpdf

### Configure CKEditor addon services

Install the plugin manually by copy to Rails asset pathes like

``` shell
vendor/assets/images/ckeditor/plugins/exportpdf/icons
vendor/assets/javascripts/ckeditor/plugins/exportpdf/lang
vendor/assets/javascripts/ckeditor/plugins/exportpdf/plugin.js
vendor/assets/javascripts/ckeditor/plugins/exportpdf/LICENSE.md
```

Edit your `app/assets/javascripts/ckeditor/config.js.coffee` like

``` coffee
CKEDITOR.editorConfig = (config) ->
  # config.extraPlugins = 'exportpdf'
  config.exportPdf_tokenUrl = 'https://example.com/cs-token-endpoint'
  true
```

Ref: https://ckeditor.com/docs/ckeditor4/latest/features/exporttopdf.html#configuration

### Configure plugins, languages, skins and base_path of CKEditor assets

Add `ckeditor_rails.rb` to `config/initializers/`

``` ruby
Ckeditor::Rails.configure do |config|
  # default is nil for all languages, or set as %w[en zh]
  config.assets_languages = nil

  # default is nil for all plugins,
  # or set as white list: %w[image link liststyle table tabletools]
  # or set as black list: config.default_plugins - %w[about a11yhelp]
  config.assets_plugins = nil

  # default is nil for all skins, or set as %w[moono-lisa]
  config.assets_skins = nil

  # default is nil and it will be "#{::Sprockets::Railtie.config.assets.prefix}/ckeditor",
  # or set as String like '/assets/ckeditor',
  # or set as Proc / Lambda
  # no slash in the end
  config.assets_base_path = nil
end
```

### Configure customized CKEDITOR_BASEPATH setting

It is important to keep these two the same.

  * `Ckeditor::Rails::AssetUrlProcessor` will post process css `url()` attribute in all css files of ckeditor based on `Ckeditor::Rails.assets_base_path`.
  * `CKEDITOR_BASEPATH` will be defined with `Ckeditor::Rails.assets_base_path` directly.

Edit your `config/initializers/ckeditor_rails.rb` like

``` ruby
Ckeditor::Rails.configure do |config|
  config.assets_base_path = Proc.new {
    base_path = ''
    if ENV['PROJECT'] =~ /editor/i
      base_path << "/#{Rails.root.basename.to_s}/"
    end
    base_path << Rails.application.config.assets.prefix
    base_path << '/ckeditor'
    base_path
  }
end
```

Note: if `Rails.application.config.action_controller.relative_url_root` is set, it will prepend to `Ckeditor::Rails.assets_base_path` automatically.

## Gem maintenance

Maintain `ckeditor_rails` gem with `Rake` commands.

Update origin CKEditor source files.

    rake update_ckeditor VERSION=4.19.0

Publish gem.

    rake release

## Troubleshooting

#### CKEditor only loading after page refresh

This is due to interference with Turbolinks -

The problem stems from the link itself so in order to resolve this issue you must disable turbolinks in the div containing the link pointing to where CKEditor is.

You can visit the Rails Turbolinks Repo for detailed documentation
https://github.com/rails/turbolinks/#opting-out-of-turbolinks

**Example**

    <div class="example" data-no-turbolink>
    ...
    </div>

#### Asset Compilation Process Does Not Produce JS and/or CSS Files

If you observe an issue (especially in Heroku environment) where asset compilation process skips JS and or CSS files, try adding the following line to `app/environments/production.rb` (or config file for the environment where you observe the issue):

``` ruby
config.assets.precompile += ['ckeditor/*']
```

Run `bundle exec rake assets:precompile` and `ls -al public/assets/ckeditor/` to check if everything is generated as expected.

## License

CKEditor use [CKEditor license](http://ckeditor.com/license).

Other parts of gem use MIT license.
