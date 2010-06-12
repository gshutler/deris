# Deris

A documentation templating engine based on [HAML](http://haml-lang.com/)

## Installation

Whenever significant functionality is added to deris a new gem will be added to
[rubygems](http://rubygems.org/gems/deris) so installation is easy:

    gem install deris

## Getting started

Deris takes and transforms the contents of one directory and transforms and 
writes it out to another directory. Your source directory should be laid out
something like this:

    myproject/
      _src/
        layout.haml

`_src/layout.haml` is the only file deris expects to exist.

Any files and directories within `myproject` that aren't within `_src` will be
copied over to the output directory. This lets you have static content such as
CSS files and images.

To get deris to generate HTML from this directory you'll want to call it like 
this:
  
    require 'rubygems'
    require 'deris'
    
    Deris::Project.new('myproject/').write('myoutput/')

Which will result in an output like this:

    myoutput/
      index.html

This is because the contents of the `_src` directory are used to create the
`index.html` for your site.

If you want to take advantage of the templating capabilities you will want to
create a `layout.haml` something like this:

    -# myproject/_src/layout.haml
    !!! 5
    %html

      %head
        %title 
          Deris example
        
      %body
      
        %h1 Deris example
        
        #content_wrapper
                      
          #content
            =partial :content

You will now want to create a `content.haml` to provide the markup for the 
`:content` partial:

    -# myproject/_src/content.haml
    %h3 Home page
    
    %p
      As this is in the _src directory it will be used to create index.html

If you want to add another generated page to the site you need to create a new
directory under the `_src`:

    myproject/
      _src/
        morrisons/
          content.haml
        content.haml
        layout.haml

When the page is generated it will take the name of the directory, in this case
that means the file will be called `morrisons.html`. Each directory can override
the partials from its parent. This means that `morrisons.html` will be created
by the combination of `_src/layout.haml` and `_src/morrisons/content.haml`. 

You can nest directories within other directories as well:

    myproject/
      _src/
        morrisons/
          bread/
            content.haml
          content.haml
        content.haml
        layout.haml

Which will result in an output like this:

    myoutput/
      morrisons/
        bread.html   # _src/layout.haml + _src/morrisons/bread/content.haml
      index.html     # _src/layout.haml + _src/content.haml
      morrisons.html # _src/layout.haml + _src/morrisons/content.haml

## Getting help

You can get hold of me [on twitter](http://twitter.com/gshutler), [through a
message on github](http://github.com/inbox/new/gshutler) or even via ye olde 
email at garry@robustsoftware.co.uk
