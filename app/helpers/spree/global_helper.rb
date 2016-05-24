module Spree
  module GlobalHelper

    def search_url(taxon=nil, keywords='', options={})
      products_path(options.merge(taxon: taxon, keywords: keywords))
    end

    def get_taxons(taxon=nil, depth=nil)
      taxons = taxon.present? ? taxon.self_and_descendants : Spree::Taxon.all
      taxons = taxons.where('depth < ?', depth) if taxons.any? && depth.present?
    end

    def get_products(per_page=Spree::Config[:products_per_page], page_number=1, taxon=nil)
      products = taxon.present? ? taxon.products : Spree::Product
      products.page(page_number).per(per_page)
    end

    def previous_orders
      try_spree_current_user.orders.complete.order(completed_at: :desc) if try_spree_current_user.present?
    end

    def product_option_types(product)
      product.option_types
    end

    def cart_info(text = nil)
      css_class = nil

      if simple_current_order.nil? or simple_current_order.item_count.zero?
        text = "<span class='glyphicon glyphicon-shopping-cart'></span> 0"
        css_class = 'empty'
      else
        text = "<span class='glyphicon glyphicon-shopping-cart'></span> #{simple_current_order.item_count}"
        css_class = 'full'
      end

      text.html_safe
    end

    def first_level_taxons(taxon)
      taxon.children.where(depth: 1)
    end

    def fetch_products_count_by_taxon(taxon)
      Spree::Classification.where(taxon_id: taxon.self_and_descendants.pluck(:id)).count
    end
  end
end
