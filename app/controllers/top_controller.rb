class TopController < FrontBase
  def index
    @items = {}
    @items[:pickup] = Item.published.where(pickup: true).order(id: :desc).limit(6)
    @items[:new] = Item.published.where(arrival_new: true).order(id: :desc).limit(6)
    @favorites = current_member.favorites if member_signed_in?
    @topics = Topic.order(created_at: :desc).limit(3)
    render '/top'
  end
end
