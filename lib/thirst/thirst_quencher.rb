require 'mechanize'
require 'nokogiri'

class Pub
  attr_accessor :name, :latitude, :longitude

  def Pub::all
    Pub::get_me_them_pubs
  end

  def Pub::get_me_them_pubs
    unless defined? @@pubs
      @@pubs = load_pub_list
    end
    @@pubs
  end

  def Pub::load_pub_list
    agent = Mechanize.new
    agent.get 'http://www.svenskaolframjandet.se'
    xml_page = agent.get 'http://www.svenskaolframjandet.se/system/files/Pubs.lmx'
    xml_page.body

    pub_list = []

    parsed_xml = Nokogiri.parse xml_page.body
    landmark_nodes = parsed_xml.search './/lm:landmark'
    landmark_nodes.each do |landmark| 
      pub_list << Pub::one_node_to_pub landmark
    end
    pub_list
  end

  def Pub::one_node_to_pub node
      pub = Pub.new
      pub.name =      landmark.search( './/lm:name' ).inner_text
      pub.latitude  = landmark.search( './/lm:latitude' ).inner_text.to_f
      pub.longitude = landmark.search( './/lm:longitude' ).inner_text.to_f
      pub
  end
end
