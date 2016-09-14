module DDReleaser
  class ReleaseNotes
    class ValidationError < DDReleaser::Error
    end

    def initialize(version:, date:, body:)
      @version = version
      @date = date
      @body = body
    end

    def validate_against(version)
      unless @version =~ /\A\d\.\d\.\d\z/
        raise ValidationError, "version specified in release notes (#{@version}) is malformed"
      end

      unless @date =~ /\A\d{4}-\d{2}-\d{2}\z/
        raise ValidationError, "date specified in release notes (#{@date}) is malformed"
      end

      unless @version == version
        raise ValidationError, "version specified in release notes (#{@version}) does not match release version (#{version})"
      end
    end
  end
end
