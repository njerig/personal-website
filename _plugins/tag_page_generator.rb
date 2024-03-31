module Jekyll

  class TagPageGenerator < Generator
    safe true

    def get_all_tags(site)
      site.documents.flat_map { |doc| doc.data['tags'] || [] }.uniq
    end

    def generate(site)
      all_tags = self.get_all_tags(site)
      all_tags.each do |tag|
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