module ProoflinkConnect::PortableContacts
  class Person

    # Encapsulates a person. Each of the portable contact and opensocial contact fields has a rubyfied (underscored) accessor method.
    #
    # @person = @person.display_name
    #

    def initialize(data={})
      @data=data
    end

    SINGULAR_FIELDS = [
      # Portable contacts singular fields
      :id, :display_name, :name, :nickname, :published, :updated, :birthday, :anniversary,
      :gender, :note, :preferred_username, :utc_offset, :connected,

      # OpenSocial singular fields
      :about_me, :body_type, :current_location, :drinker, :ethnicity, :fashion, :happiest_when,
      :humor, :living_arrangement, :looking_for, :profile_song, :profile_video, :relationship_status,
      :religion, :romance, :scared_of, :sexual_orientation, :smoker, :status
    ]
    PLURAL_FIELDS = [
      # Portable contacts plural fields
      :emails, :urls, :phone_numbers, :ims, :photos, :tags, :relationships, :addresses,
      :organizations, :accounts,

      # OpenSocial plural fields
      :activities, :books, :cars, :children, :food, :heroes, :interests, :job_interests,
      :languages, :languages_spoken, :movies, :music, :pets, :political_views, :quotes,
      :sports, :turn_offs, :turn_ons, :tv_shows
    ]

    ENTRY_FIELDS = SINGULAR_FIELDS + PLURAL_FIELDS

    def [](key)
      @data[key.to_s.camelize(:lower)]
    end

    # primary email address
    def email
      @email||= begin
        (emails.detect {|e| e['primary']=='true '} || emails.first)["value"] unless emails.empty?
      end
    end

    def id
      self["id"]
    end

    protected

    def method_missing(method,*args)
      if respond_to?(method)
        return self[method]
      end
      super
    end

    def respond_to?(method)
      ENTRY_FIELDS.include?(method) || @data.has_key?(method.to_s.camelize(:lower)) || super
    end
  end
end