# Formie

[![Gem Version](https://badge.fury.io/rb/formie.svg)](https://badge.fury.io/rb/formie)
[![GEM Downloads](https://img.shields.io/gem/dt/formie?color=168AFE&logo=ruby&logoColor=FE1616)](https://rubygems.org/gems/formie)
[![rake](https://github.com/matique/formie/actions/workflows/rake.yml/badge.svg)](https://github.com/matique/formie/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](http://choosealicense.com/licenses/mit/)

Tired of programming each HTML tag?
Are you in search of DRYness for Rails views?
May be Formie can help you.

Formie implements low level template-based helpers.
It injects the formies into the ActionView module.
The form-bounded as well as the unbounded templates are supported.
Still, the ActionView functionality (e.g. text_field) is kept untouched.
In short, Formie is like a helper using the notation of a partial.

Templates handlers are supported as in partials.

## Installation

As usual:
```ruby
# Gemfile
gem "formie"
```
and run "bundle install".

## Description

Templates for Formie are hosted in:

- <formie_path>/forms       (bounded to form)
- <formie_path>/application (free standing)
- <formie_path>/templates   (free standing)

Till Rails 5 <formie_path> is 'app/formies'.
Starting at Rails 6 <formie_path> is 'app/views/formies'.

Version 1.1.0+ is intended for Rails 7

Inside a formie the following locals (as delivered by the
controller) are available:

|Name | Description
| --- | ---
| action_name
| args | remainings after extracting options/locals
| block | block passed to the formie
| controller_name
| form | (available inside form_with (similar to fields_for))
|  form.object
| params

Locals are passed in a hash.
The controller attributes are available as usual.

To avoid a server restart during development of formies you may add to:

```ruby
# app/controllers/application_controller.rb

before_filter do
  Formie.reload  if Rails.env.development?
end
```

## Examples (see also tests)

```ruby
<%= copyright %>
<%= back %>
<%= show obj: @order %>

<%= form_with model: Order do |f| %>
  <%= f.l_text_field :who %>
  <%= f.l_text_field :amount %>
<% end %>
```

In directory <formie_path> :

```ruby
# application/copyright.html.erb
<div class="copyright"> Copyright (c) 2009 </div>

# application/back.html.erb
<a href="<%= "/#{h(controller_name)}" %>"> Back </a>

# application/show.html.erb
<a href="<%= "/#{h(controller_name)}/#{obj.id}" %>"> Show </a>

# forms/l_text_field.html.erb
<% field = args.first %>
<p>
  <%= form.label field %><br />
  <%= form.text_field field %>
</p>

# templates/hello.slim
/ a comment

span Hello Slim
```

## Miscellaneous

Copyright (c) 2009-2024 Dittmar Krall (www.matiq.com),
released under the [MIT license](https://opensource.org/licenses/MIT).
