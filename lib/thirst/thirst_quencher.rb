require 'mechanize'
require 'nokogiri'
require 'json'
require 'geocoder'

include Geocoder::Calculations

class Pub
  attr_accessor :name, :latitude, :longitude

  def location
    [latitude, longitude]
  end

  def Pub::find options = {}
    agent = Mechanize.new
    if options[:address]
      address = options[:address]
      point = Geocoder.search( address ).first.data['geometry']['location']
      location = [point['lat'],point['lng']]
    else
      page = agent.get 'http://freegeoip.net/json/'
      location = JSON.parse page.body
      my_latitude  = location['latitude'] 
      my_longitude = location['longitude']
      location = [my_latitude,my_longitude]
    end
    sorted_pubs = Pub::find_near location
    sorted_pubs.first
  end

  def Pub::find_near location
    Pub::all.sort do |one, other|
      distance_to_one =   distance_between location, one.location
      distance_to_other = distance_between location, other.location
      distance_to_one <=> distance_to_other
    end
  end

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
    parsed_xml = Nokogiri.parse get_xml_from_olframjandet
    landmark_nodes = parsed_xml.search './/lm:landmark'
    landmark_nodes.map { |landmark| Pub::one_node_to_pub( landmark ) }
  end

  def Pub::get_xml_from_olframjandet
    agent = Mechanize.new
    agent.get 'http://www.svenskaolframjandet.se' # seems like you need to get a session to get the file
    xml_page = agent.get 'http://www.svenskaolframjandet.se/system/files/Pubs.lmx'
    xml_page.body
  end

  def Pub::one_node_to_pub landmark
      pub = Pub.new
      pub.name =      landmark.search( './/lm:name' )     .inner_text
      pub.latitude  = landmark.search( './/lm:latitude' ) .inner_text.to_f
      pub.longitude = landmark.search( './/lm:longitude' ).inner_text.to_f
      pub
  end
end
