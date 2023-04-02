defmodule SchoolWeb.MedianLiveTest do
  use SchoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import School.DataFixtures

  defp create_data(_) do
    data = data_fixture()
    %{data: data}
  end

  describe "Live" do
    setup [:create_data]

    test "lists data", %{conn: conn, data: _data} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Law School First Year Class"
      assert html =~ "Yale University"
    end

    test "school score", %{conn: conn, data: _data} do
      {:ok, index_live, _html} = live(conn, ~p"/")

      html =
        index_live
        |> element("span:first-child", "view scores")
        |> render_click()

      assert html =~ "Yale University"
      assert html =~ "LSAT Median Scores"
      assert html =~ "GPA Median Scores"
      assert html =~ "GRE Verbal Median Scores"
      assert html =~ "GRE Quantitative Median Scores"
      assert html =~ "GRE Writing Median Scores"
    end
  end

end
