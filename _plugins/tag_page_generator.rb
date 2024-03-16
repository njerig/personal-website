module Jekyll
  class TagPageGenerator < Generator
    safe true

    EXCLUDED_COLLECTION = 'projects'

    def generate(site)
      site.tags.each_key do |tag|
        tag_in_excluded_collection = site.tags[tag].any? do |post|
          post.data['collection'] == EXCLUDED_COLLECTION
        end

        next if tag_in_excluded_collection

        site.pages << TagPage.new(site, site.source, tag)
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, tag)
      @site = site
      @base = base
      @dir  = File.join("tagged", tag)
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_page.html')
      self.data['tag'] = tag
      self.data['title'] = "\##{tag}"
    end
  end
end