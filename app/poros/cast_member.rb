class CastMember
  attr_reader :cast_member_id,
              :name,
              :character

  def initialize(attributes)
    @cast_member_id = attributes[:id]
    @name = attributes[:name]
    @character = attributes[:character]
  end
end