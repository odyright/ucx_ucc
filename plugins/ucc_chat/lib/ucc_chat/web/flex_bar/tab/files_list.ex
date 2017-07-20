defmodule UccChat.Web.FlexBar.Tab.FilesList do
  use UccChat.Web.FlexBar.Helpers

  alias UccChat.Attachment

  def add_buttons do
    TabBar.add_button %{
      module: __MODULE__,
      groups: ~w[channel group direct im],
      id: "uploaded-files-list",
      title: ~g"Room uploaded file list",
      icon: "icon-attach",
      view: View,
      template: "files_list.html",
      order: 60
    }
  end

  def args(user_id, channel_id, _, _) do
    [
      current_user: Helpers.get_user!(user_id),
      attachments: Attachment.get_attachments_by_channel_id(channel_id)
    ]
  end
end
