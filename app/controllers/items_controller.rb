class ItemsController < FrontBase
  def index
    @search_form = ItemSearchForm.new(search_params)
    @items = @search_form.search(params[:page])
    @favorites = current_member.favorites.where(item: @items.map{|item| item.id}) if member_signed_in?
    session['item_search_params'] = view_context.search_conditions_keeper(params, [:category_id, :name, :order_type, :price_floor, :price_ceil])
    render '/top' if request.fullpath == '/'
  end

  def show
    @item = Item.published.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  private
  def search_params
    return  nil if params[:item_search_form].nil?
    params.require(:item_search_form).permit(:category_id, :keyword, :sold_out, :sort_type, :price_floor, :price_ceil)
  end
end
