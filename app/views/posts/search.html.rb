<% title "Posts Results" %>

<table>
  <tr>
    <th>Title</th>
    <th>Body</th>
  </tr>
  <% for posts in @posts %>
    <tr>
      <td><%=h posts.title %></td>
      <td><%=h posts.body %></td>
      <td><%= link_to "Show", posts %></td>
      <td><%= link_to "Edit", edit_post_path(posts) %></td>
      <td><%= link_to "Destroy", posts, :confirm => 'Are you sure?', :method => :delete %></td>
    </tr>
  <% end %>
</table>

<p><%= link_to "New Posts", new_post_path %></p>
