set -e # halt script on error

bundle exec jekyll build
bundle exec html-proofer ./_site --only-4xx --disable-external --allow-hash-href