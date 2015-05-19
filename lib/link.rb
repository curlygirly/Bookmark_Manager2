class Link

  include DataMapper::Resource
 # this makes the instances of this class Datamapper resources
  property :id, Serial
  property :title, String
  property :url, String

  has n, :tags, through: Resource


end