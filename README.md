The Processing.js website
=========================

This is our website, in all its glory.

Testing the website locally
---------------------------

Install [Jekyll](https://github.com/mojombo/jekyll/wiki/Install) on your computer,
clone this repository, and run `jekyll` inside the root of the repository. 

To match Github Pages, you'll need to install Jekyll v0.11.0, uninstall Liquid v2.3.0
(`gem uninstall liquid`), then install Liquid v2.2.2 (`gem install liquid -v 2.2.2`).  For this
combination to work, you'll need to be running ruby 1.8.7; ruby 1.9.x fails with an "invalid byte 
sequence in UTF-8" ArgumentError. 

Jekyll will compile (yes, seriously) the website into the _site directory, and start a
localhost web server running on port 4000. Jekyll will automatically recompile the site
if you make any changes.

Updating the blog
-----------------

The blog index is `/blog/index.html`, and all of the individual blog posts are located in
`/blog/_posts/`. I've created a template blog post in `/blog/_posts/template.html`, but for
posterity, here it is:

    --- 
    layout: post
    title: Template blog title
    ---
    <p>Write your blog post here</p>

Once you've changed the title to something appropriate and written something useful for the
blog post, you need to save the blog post with a specific filename within the _posts
directory to have Jekyll pick it up as a blog post. The format is `yyyy-mm-dd-title-with-dashes.ext`,
where ext can be html, md, or textile.

Updating the downloads
----------------------

The downloads index is `/downloads/index.html`, and all of the files for download are located
at [https://github.com/processing-js/processing-js/downloads](https://github.com/processing-js/processing-js/downloads).
Each release of Processing.js gets a post in the `/downloads/_posts/` directory which contains
links for each download.
Everyone with the right access (see below) should upload the files to the Github Downloads
page, then update the Processing.js Downloads page to point to the new files.

Updating the exhibitions
------------------------

The exhibitions index is `/exhibition/index.html`, and all of the individual exhibitions are
located in `/exhibition/_posts/`. I've created a template exhibition in
`/exhibition/_posts/template.html`, but it's here too:

    <span>
      <a href="linktodemo">
        <img src="/images/exhibition/linktoimage.png" width="180" height="75" />
      </a>
      <br /><a href="linktodemo">Demoname</a><br />by<br />
      <p><a href="linktotwitter">Authors</a></p>
      <p>Description</p>
    </span>

You'll need a make a 180x75 screenshot of the exhibition in question, and put that in
`/images/exhibition/`. Once you done that, fill out the rest of the information in the
template. Like blog posts, you'll need to name the exhibition  in a specific format so
that it's picked up by Jekyll: `yyyy-mm-dd-title-with-dashes.ext`, where ext can be html,
md, or textile. To preserve the order of exhibitions on the index page, I just incremented
the date by one day for each exhibition.

Updating the articles
---------------------

The articles index is `/articles/index.html`, and all of the individual articles are located
in `/articles/_posts/`. The template is at `/articles/_posts/template.html`, but let's look
at it anyways:

    ---
    layout: default
    desc: Jon's Guide to ASDF
    title: ASDF Guide
    permalink: /articles/ASDFGuide.html
    ---
    <p>This is my lovely article about ASDF</p>

The desc is a short description of the article that's shown on the Articles index page. The
title is the actual title of the article. The permalink is where the article should actually
be placed when compiled; by default it gets a URL with the publish date, which is something
we don't care about. Like blog posts and exhibitions, you'll need to name the exhibition in
a specific format so that it's picked up by Jekyll: `yyyy-mm-dd-title-with-dashes.ext`, where
ext can be html, md, or textile.

If you want to update the list of articles that appears on the front page, you'll need to edit
the default layout in `/_layouts/default.html`.

Updating the front page
-----------------------

The front page index is `/index.html`. If you're editing the front page text or exhibitions,
this is the place to do it.

Updating anything else
----------------------

Everything else is static content. Go to the exact file you're looking for, and make whatever
changes you need to make!

Layouts
-------

On almost every single page you see, there's a few lines of text that looks like this:

    ---
    layout: default
    ---

This YAML front matter tells Jekyll to use the layout in `_layouts` named `default`. In this
case, `_layouts/default.html`. There's another layout for blog posts called `post` which
inherits from `default`. Be careful about making changes to these layouts, as it affects
pretty much every other page. Everything that you link to from this page must be linked in
an absolute fashion, with a `/` at the front.

Access controls
---------------

Who is allowed to update the git repository is controlled by the Processing.js
[organization settings](https://github.com/organizations/processing-js/teams) on Github.

Hosting considerations
----------------------

The Processing.js site will work on any hosting service that serves content with the
correct MIME type. The only content on the website that is not stored within the
repository is the various Processing.js releases on our Downloads page. Those are
currently stored in the [Github Downloads page](https://github.com/processing-js/processing-js/downloads)
for Processing.js. If we had to move from Github Pages hosting to somewhere else, we'd
need to update the download links on our Downloads page. We'd also need to figure out
access controls for new hosting; the access controls for Github are everyone added to
the [Processing.js organization](https://github.com/processing-js).
