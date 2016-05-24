module Spree
  Taxon.class_eval do
    scope :non_roots, -> { where.not(parent_id: nil).order(:position) }
  end
end
