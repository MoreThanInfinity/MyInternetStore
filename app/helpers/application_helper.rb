module ApplicationHelper
  def creating(obj)
    obj.created_at.to_s.chomp(" UTC")
  end

  def updating(obj)
    obj.updated_at.to_s.chomp(" UTC") if obj.updated_at
  end

  def separate(record)
    if record.to_s.size > 20
      record.to_s[0..20]+'...'
    else
      record
    end
  end
end
