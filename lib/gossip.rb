# frozen_string_literal:true

class Gossip
  attr_accessor :author, :content, :author_comments, :comments

  def initialize(author, content, author_comments = [], comments = [])
    @author = author
    @content = content
    @comments = comments
    @author_comments = author_comments
  end

  def save
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    gossip_array = []
    CSV.read('db/gossip.csv').each do |csv|
      if csv.length > 2
        author_comments = csv.values_at(* csv.each_index.select{|i| i>1 && i.even?})
        comments = csv.values_at(* csv.each_index.select{|i| i>1 && i.odd?})
      else
        author_comments, comments = [[],[]]
      end
      gossip_array << Gossip.new(csv[0], csv[1], author_comments, comments)
    end
    gossip_array
  end

  def self.find(id)
    self.all[id]
  end

  def self.update(id, gossip_author, gossip_content)
    gossips = CSV.read('db/gossip.csv')
    gossips[id][0] = gossip_author
    gossips[id][1] = gossip_content
    CSV.open('db/gossip.csv', 'w') do |csv|
      gossips.each{|gossip| csv << gossip}
    end
  end

  def self.add_comment(id, author, comment)
    gossips = CSV.read('db/gossip.csv')
    if comment != ''
      author == '' ? gossips[id] << 'Anonymous' : gossips[id] << author
      gossips[id] << comment
      CSV.open('db/gossip.csv', 'w') do |csv|
        gossips.each{|gossip| csv << gossip}
      end
    end
  end
end
