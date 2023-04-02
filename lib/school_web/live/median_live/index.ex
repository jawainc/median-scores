defmodule SchoolWeb.MedianLive.Index do
  use SchoolWeb, :live_view

  alias School.{Medians, Medians.Data, Helpers}

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
        |> assign(:page, 1)
        |> assign(:filter, nil)
        |> assign(:show_school, false)
        |> assign(:total_pages, Helpers.get_total_pages(Data))
        |> paging_query()

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing School")
  end

  @impl true
  def handle_event("search-filter", %{"search" => value}, socket) do
    total_pages = Helpers.get_total_pages(Helpers.make_filters(Data, value))
    socket =
      socket
      |> assign(:page, 1)
      |> assign(:filter, value)
      |> assign(:total_pages, total_pages)
      |> paging_query()

    {:noreply, socket}
  end

  def handle_event("next-page", _params, socket) do
    socket =
      socket
      |> assign(:page, socket.assigns.page + 1)
      |> paging_query()

    {:noreply, socket}
  end

  def handle_event("previous-page", _params, socket) do
    socket =
      socket
      |> assign(:page, socket.assigns.page - 1)
      |> paging_query()

    {:noreply, socket}
  end

  def handle_event("show-school", %{"id" => id}, socket) do
    school = Medians.get_school!(id)

    {:noreply,
      socket
      |> assign(:school, school)
      |> assign(:show_school, true)
    }
  end

  def handle_event("hide-school", _params, socket) do
    {:noreply, socket |> assign(:show_school, false)}
  end

  defp paging_query(socket) do
    socket
    |> assign(:schools, Medians.list_school_data((%{page: socket.assigns.page, filter: socket.assigns.filter})))
  end

end
