<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Person_Search.aspx.cs" Inherits="LabTestPortal.Person_Search" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>
    <script src="Scripts/bootstrap.js"></script>


</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 90%; margin-right: 5%; margin-left: 5%; text-align: center">
            <asp:ScriptManager runat="server" ID="ScriptManager1" />

            <h1>Person Search</h1>

            <asp:UpdatePanel ID="upPersonGrid" runat="server">
                <ContentTemplate>

                    <asp:GridView ID="gvPerson" runat="server" AutoGenerateColumns="False" DataKeyNames="person_id" DataSourceID="SqlPersonList" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="gvPerson_RowCommand" Width="100%">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>
                        <Columns>
                            <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-info" ButtonType="Button" Text="Edit" HeaderText="Edit Record">
                                <ControlStyle CssClass="btn btn-info"></ControlStyle>
                            </asp:ButtonField>
                            <asp:BoundField DataField="person_id" HeaderText="person_id" ReadOnly="True" Visible="False" SortExpression="person_id"></asp:BoundField>
                            <asp:BoundField DataField="first_name" HeaderText="First Name" SortExpression="first_name"></asp:BoundField>
                            <asp:BoundField DataField="last_name" HeaderText="Last Name" SortExpression="last_name"></asp:BoundField>
                            <asp:BoundField DataField="state_code" HeaderText="State" SortExpression="state_code"></asp:BoundField>
                            <asp:BoundField DataField="gender" HeaderText="Gender" SortExpression="gender"></asp:BoundField>
                            <asp:BoundField DataField="dob" HeaderText="DOB" HtmlEncode="false" DataFormatString="{0:d}" />
                        </Columns>
                        <EditRowStyle BackColor="#999999"></EditRowStyle>

                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>

                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                        <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White"></PagerStyle>

                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>

                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>

                        <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

                        <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

                        <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

                        <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
                    </asp:GridView>
                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#addModal">
                        Add New person
                    </button>
                    <asp:SqlDataSource ID="SqlPersonList" runat="server" CancelSelectOnNullParameter="false" ConnectionString='<%$ ConnectionStrings:LabTestPortalConnectionString %>' SelectCommand="uspPersonSearch" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter Name="id" Type="Int32" ConvertEmptyStringToNull="true"></asp:Parameter>
                            <asp:Parameter Name="first_name" Type="String" ConvertEmptyStringToNull="true"></asp:Parameter>
                            <asp:Parameter Name="last_name" Type="String" ConvertEmptyStringToNull="true"></asp:Parameter>
                            <asp:Parameter Name="state_id" Type="Int32" ConvertEmptyStringToNull="true"></asp:Parameter>
                            <asp:Parameter Name="gender" Type="String" ConvertEmptyStringToNull="true"></asp:Parameter>
                            <asp:Parameter Name="dob" Type="DateTime" ConvertEmptyStringToNull="true"></asp:Parameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="editModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h3 id="editModalLabel">Edit Person</h3>
                    </div>
                    <asp:UpdatePanel ID="upEdit" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:HiddenField ID="hdPersonID" runat="server" />
                                <table class="table table-bordered table-hover">
                                    <tr>
                                        <td>First Name : </td>
                                        <td>
                                            <asp:TextBox ID="txtFirstNameUpdate" runat="server"></asp:TextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Last Name : </td>
                                        <td>
                                            <asp:TextBox ID="txtLastNameUpdate" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>State : </td>
                                        <td>
                                            <asp:DropDownList ID="ddlStateUpdate" runat="server" DataSourceID="SqlStateList" DataTextField="state_code" DataValueField="state_id"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Gender : </td>
                                        <td>
                                            <asp:RadioButtonList ID="rbGenderUpdate" runat="server">
                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                            </asp:RadioButtonList>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Date of Birth : </td>
                                        <td>
                                            <asp:TextBox ID="txtDOBUpdate" runat="server" TextMode="Date"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <asp:Label ID="lblResult" Visible="false" runat="server"></asp:Label>
                                <asp:Button ID="btnSave" runat="server" Text="Update" CssClass="btn btn-info" OnClick="btnSave_Click" />
                                <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="gvPerson" EventName="RowCommand" />
                            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 id="addModalLabel">Add New Person</h4>
                    </div>
                    <asp:UpdatePanel ID="upAdd" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <table class="table table-bordered table-hover">
                                    <tr>
                                        <td>First Name : </td>
                                        <td>
                                            <asp:TextBox ID="txtFirstNameAdd" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>Last Name : </td>
                                        <td>
                                            <asp:TextBox ID="txtLastNameAdd" runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td>State : </td>
                                        <td>
                                            <asp:DropDownList ID="ddlStateAdd" runat="server" DataSourceID="SqlStateList" DataTextField="state_code" DataValueField="state_id"></asp:DropDownList>
                                            <asp:SqlDataSource runat="server" ID="SqlStateList" ConnectionString='<%$ ConnectionStrings:LabTestPortalConnectionString %>' SelectCommand="uspStatesList" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Gender : </td>
                                        <td>
                                            <asp:RadioButtonList ID="rbGenderAdd" runat="server">
                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                            </asp:RadioButtonList>
                                    </tr>
                                    <tr>
                                        <td>Date of Birth : </td>

                                        <td>
                                            <asp:TextBox ID="txtDOBAdd" runat="server" TextMode="Date"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnAddRecord" runat="server" Text="Add" CssClass="btn btn-info" OnClick="btnAddRecord_Click" />
                                <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>

                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAddRecord" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>


    </form>
</body>
</html>
