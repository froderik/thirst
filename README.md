thirst
======

If you ever wanted to:

    Pub.find

to get the nearest decent pub - then this gem is for you. Just:

    gem install thirst

and integrate it in whatever application you need it in. Currently you can get all pubs with:

    require 'thirst'
    Pub.all

and if you want the pub closest to where your IP is thought to be you can

    Pub.find

furthermore an options hash can give you the closest pub to an address of a point:

    oliver = Pub.find :address => "Repslagargatan 6, Stockholm"
    oliver.name.should == 'Oliver Twist'

    amsterdam = Pub.find :point => [57.71, 11.98]
    amsterdam.name.should == 'Het Amsterdammertje'

Each pub has a name, a latitude and a longitude. More will come later.


limitations
===========

The gem is backed up with pubs in Sweden from the list maintained by Svenska Ölfrämjandet. This data is released under a creative commons license as detailed below. You can not use this gem commercially without a specific deal with Svenska Ölfrämjandet. If you feel you need this for your own country go ahead and contribute.

<div xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/" about="http://www.svenskaolframjandet.se/pubs_for_gps"><span property="dct:title">Svenska Ölfrämjandets pubdatabas</span> (<a rel="cc:attributionURL" property="cc:attributionName" href="http://www.svenskaolframjandet.se">Svenska Ölfrämjandet</a>) / <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/2.5/se/">CC BY-NC-SA 2.5</a></div> 

