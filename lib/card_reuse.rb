module CardReuse
  def all_cards_for_user(user)
    return nil unless user

    orders = Order.where(:user_id => user.id).complete.order(:created_at).joins(:payments).where('payments.source_type' => 'Creditcard').where('payments.state' => 'completed')
    payments = orders.map(&:payments).flatten

    payments.map{|payment| payment.source unless payment.source.deleted?}.compact
  end
end
