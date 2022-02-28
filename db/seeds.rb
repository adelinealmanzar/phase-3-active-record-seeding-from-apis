puts "Seeding spells..."
# these are the spells we want to add to the database
spells = ["acid-arrow", "animal-messenger", "calm-emotions", "charm-person"]

#iterate over each spell
spells.each do |spell|
    # make a request to api endpoint for each individual spell (synchronous)
    response = RestClient.get "https://www.dnd5eapi.co/api/spells/#{spell}"

    #convert response in JSON formatted string to Ruby hash
    spell_hash = JSON.parse(response)

    #create spell in db from spell_hash data from endpoint
    Spell.create(
        name: spell_hash["name"],
        level: spell_hash["level"],
        description: spell_hash["desc"][0] #spell_hash["desc"] returns an array, so first index to get just a string of the description
    )
end

puts "Done seeding!"