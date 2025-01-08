class RemoveReferencesInnOwnerToFavoriteList < ActiveRecord::Migration[7.1]
  def change
    remove_reference :favorite_lists, :inn_owner, index: true, foreign_key: true
    add_reference :favorite_lists, :inn_user, index: true, foreign_key: true
  end
end