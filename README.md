# Frank sinatra
# Sinatra Framework Course

> Created on 29/07/2019 by Quentin Churet.

**Note aux correcteurs**

Type and run `shotgun -p 4567` and type in your favorite browser
`http://localhost:4567/`

## Taux d'avancement : 100%

- MVC Architecture : config.ru, lib folder containing views + controller.rb + gossip.rb
- Different Views : Index page, Gossip Individual page, Edit Gossip page, New Gossip page
- Controller : All the get/post request are working
- Gossip class : see below for the different available methods
- Database link : gossip.csv fully functional
- Dynamic URLs
- Dynamic ERB files using Ruby
- Comments functionality available

## Content

- **db** : gossip.csv, CSV file containing the gossips (author, content, \*\*comments)
- **lib/views** : Contains the different ERB files : index, new_gossip, gossip_page, edit
- **lib/controller.rb** : MVC Controller. Redirect to the different model of the website
- **config.ru** Rack Up file, Ruby standard that launches a server
- **Gemfile** Contains all the necessary gems for this program

## Classes

### Gossip

Instance Variables

- author : author of the gossip (string)
- content : content of the gossip (string)
- author_comments : list of authors of the different comments (array)
- comments : list of the different comments related to the gossip (array)

Instance Methods

- save : Save a new gossip instance into the csv file

Class Methods

- self.all : returns an array containing all the gossips in Gossip Object format
- self.find(index): return a Gossip Object by its position in the Database
- self.update(id, gossip_author, gossip_content) modify the content of a gossip
- self.add_comment(id, author, comment) : add a comment to a gossip

## Database

**gossip.csv** : stores all the gossips row by row

Structure of a row :
author, content, comment_author1, comment1, comment_author2, comment2...
