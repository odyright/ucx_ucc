defmodule UccChatWeb.RebelChannel.Client do
  import Rebel.Query
  import Rebel.Core

  alias UccChatWeb.ClientView

  require Logger

  def page_loading(socket) do
    insert socket, ClientView.page_loading, prepend: "head"
    socket
  end

  def remove_page_loading(socket) do
    delete socket, "head > style"
    socket
  end

  def start_loading_animation(socket, elem) do
    socket
    |> page_loading
    |> exec_js("$('#{elem}').next().after('#{ClientView.loading_animation}')")
    socket
  end

  def stop_loading_animation(socket) do
    socket
    |> remove_page_loading()
    |> delete(from: ".loading-animation")
    socket
  end

  def set_ucxchat_room(socket, room, display_name, _route \\ "channels") do
    broadcast_js(socket, "window.UccChat.ucxchat.room = '#{room}'; " <>
      "window.UccChat.ucxchat.display_name = '#{display_name}'")
    |> case do
      {:ok, _} ->
        socket
      {:error, error} ->
        raise "set_ucxchat_room error: #{inspect error}"
    end
  end

  def push_history(socket, room, display_name, route \\ "channels") do
    socket
    |> set_ucxchat_room(room, display_name, route)
    |> push_history()
  end

  def push_history(socket) do
    broadcast_js(socket, "history.replaceState(history.state, " <>
      "window.UccChat.ucxchat.display_name, '/' + ucxchat.room_route " <>
      "+ '/' + window.UccChat.ucxchat.display_name)")
    |> case do
      {:ok, _} ->
        socket
      {:error, error} ->
        raise "push_history error: #{inspect error}"
    end
  end

  def replace_history(socket, room, display_name, route \\ "channels") do
    socket
    |> set_ucxchat_room(room, display_name, route)
    |> replace_history()
  end

  def replace_history(socket) do
    broadcast_js(socket, "history.replaceState(history.state, " <>
      "ucxchat.display_name, '/' + ucxchat.room_route + '/' + " <>
      "ucxchat.display_name)")
    |> case do
      {:ok, _} ->
        socket
      {:error, error} ->
        raise "replace_history error: #{inspect error}"
    end
  end

  def toastr!(socket, which, message) do
    toastr socket, which, message
    socket
  end

  def toastr(socket, which, message) do
    exec_js socket, ~s{window.toastr.#{which}("#{message}");}
  end
end
