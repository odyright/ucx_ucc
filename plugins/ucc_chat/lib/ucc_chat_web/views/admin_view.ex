defmodule UccChatWeb.AdminView do
  use UccChatWeb, :view

  import UccAdminWeb.View.Utils, warn: false

  def room_type(0), do: ~g"Channel"
  def room_type(1), do: ~g"Private Group"
  def room_type(2), do: ~g"Direct Message"

  def render_user_action_button(user, "admin") do
    if User.has_role? user, "admin", nil do
      render "user_action_buttons.html", opts: %{type: :danger, action: "remove-admin", icon: :shield, label: ~g(REMOVE ADMIN)}
    else
      render "user_action_buttons.html", opts: %{type: :secondary, action: "make-admin", icon: :shield, label: ~g(MAKE ADMIN)}
    end
  end

  def render_user_action_button(user, "activate") do
    if user.active do
      render "user_action_buttons.html", opts: %{type: :danger, action: "deactivate", icon: :block, label: ~g(DEACTIVATE)}
    else
      render "user_action_buttons.html", opts: %{type: :secondary, action: "activate", icon: "ok-circled", label: ~g(ACTIVATE)}
    end
  end

  def render_user_action_button(_user, "edit") do
    render "user_action_buttons.html", opts: %{type: :primary, action: "edit-user", icon: :edit, label: ~g(EDIT)}
  end

  def render_user_action_button(_user, "delete") do
    render "user_action_buttons.html", opts: %{type: :danger, action: "delete", icon: :trash, label: ~g(DELETE)}
  end

  def admin_type_label(%{type: 0}), do: ~g(Channel)
  def admin_type_label(%{type: 1}), do: ~g(Private Group)
  def admin_type_label(%{type: 2}), do: ~g(Direct Message)

  def admin_state_label(%{archived: true}), do: ~g(Archived)
  def admin_state_label(_), do: ~g(Active)

  def admin_label(channel, field) do
    channel
    |> Map.get(field)
    |> do_admin_label
  end
  def admin_label(item), do: do_admin_label(item)

  defp do_admin_label(true), do: ~g(True)
  defp do_admin_label(false), do: ~g(False)

  def get_slash_commands(item, field) do
    item |> Map.get(field) |> String.split("\n")
  end
end
