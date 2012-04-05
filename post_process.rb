#!/usr/bin/env ruby -rubygems

require 'nokogiri'
require 'liquid'

build_dir = "build"
template_file = "layout.html"

def readfile(filepath)
  content = ""
  File.open(filepath) do |f|
    content = f.read
  end
  content
end

Dir.glob("#{build_dir}/*.html").each do |filepath|
  puts "processing #{filepath}..."
  doc = Nokogiri::HTML(readfile(filepath), nil, "UTF-8")
  title = doc.at_css("title").content
  metas = doc.css("meta[name]")
  navlink = doc.css("#org-div-home-and-up").inner_html
  content = doc.at_css("div#content").inner_html

  template = Liquid::Template.parse(readfile(template_file))
  output = template.render({
      "title" => title, "metas" => metas.to_s, "content" => content,
      "navlink" => navlink
    })
  File.open(filepath, 'w') {|f| f.write(output) }
end

