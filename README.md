The Processing.js website
=========================

This is our website, in all it's glory.

Testing the website locally
---------------------------

Install [Jekyll](https://github.com/mojombo/jekyll/wiki/Install) on your computer,
clone this repository, and run `jekyll` inside the root of the repository. 

To match Github Pages, you'll need to install Jekyll v0.11.0, uninstall Liquid v2.3.0
(`gem uninstall liquid`), then install Liquid v2.2.2 (`gem install liquid -v 2.2.2`).

Jekyll will compile (yes, seriously) the website into the _site directory, and start a
localhost web server running on port 4000. Jekyll will automatically recompile the site
if you make any changes.

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
