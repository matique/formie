Formie
======

Tired of programming each HTML tag? Are you in search of DRYness for Rails
views? May be Formie can help you.

Formie is a low level template-based rendering engine. It injects
the formies into the ActionView module. The form-bounded as well as
the unbounded templates are supported. Still, the ActionView
functionality (e.g. text_field) is kept untouched.
In short, Formie is like a helper using the notation of a partial.

Templates for Formie are hosted in:

- app/formies/forms       (bounded to form)
- app/formies/application (free standing)

Inside a formie the following locals (as delivered by the
controller) are available:

- action_name
- args          remainings after extracting options/locals
- block         block passed to the formie
- controller_name
- form          (available inside form_for (similar to fields_for))
-   form.object
- params

Locals are passed by a hash.
The controller attributes are available as usual.

To avoid a server restart during development of formies you may add to:

    # app/controllers/application_controller.rb

    before_filter do
      Formie.reload  if 'development' == Rails.env
    end


Examples
========

    <%= copyright %>
    <%= back %>
    <%= show :obj => @order %>

    <%= form_for :order do |f| %>
      <%= f.who %>
      <%= f.amount %>
    <% end %>

In directory app/formies :

    # application/copyright.html.erb
    <div class="copyright"> Copyright (c) 2009 </div>

    # application/back.html.erb
    <a href="<%= "/#{h(controller_name)}" %>"> Back </a>

    # application/show.html.erb
    <a href="<%= "/#{h(controller_name)}/#{obj.id}" %>"> Show </a>

    # forms/who.html.erb
    <%= form.labelled_field :field => :who %>

    # forms/amount.html.erb
    <%= form.labelled_field :field => :amount %>

    # forms/labelled_field.html.erb
    <label style="width: 8em; display: block; float: left;">
      <%= field.to_s.capitalize %>
    </label>
    <%= form.text_field field %> <br />


Copyright (c) 2009..2012 Dittmar Krall, released under the MIT license
