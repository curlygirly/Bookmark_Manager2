class Link

  include DataMapper::Resource
 # this makes the instances of this class Datamapper resources

  has n, :tags, through: Resource

  property :id, Serial
  property :title, String
  property :url, String




end