using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace LabTestPortal
{
    public partial class Person_Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataLoad();
            }

        }

        public void DataLoad()
        {
            gvPerson.DataBind();

        }

        protected void gvPerson_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
            if (e.CommandName.Equals("editRecord"))
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow gvrow = gvPerson.Rows[index];
                hdPersonID.Value = gvPerson.DataKeys[index].Value.ToString();
                txtFirstNameUpdate.Text = HttpUtility.HtmlDecode(gvrow.Cells[2].Text);
                txtLastNameUpdate.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text);
                ddlStateUpdate.SelectedIndex = ddlStateUpdate.Items.IndexOf(ddlStateUpdate.Items.FindByText(HttpUtility.HtmlDecode(gvrow.Cells[4].Text)));
                rbGenderUpdate.SelectedValue = HttpUtility.HtmlDecode(gvrow.Cells[5].Text);
                txtDOBUpdate.Text = DateTime.Parse( HttpUtility.HtmlDecode(gvrow.Cells[6].Text)).ToString("yyyy-MM-dd");
                lblResult.Visible = false;
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#editModal').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditModalScript", sb.ToString(), false);

            }

        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            string message = string.Empty;
            if (txtFirstNameUpdate.Text == "" || txtLastNameUpdate.Text == "" || ddlStateUpdate.SelectedIndex < 0 || rbGenderUpdate.SelectedIndex < 0 || txtDOBUpdate.Text == "")
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("alert('Missing information, record not added!');");
                sb.Append("$('#addModal').modal('hide');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);

            }
            else
            {
                try
                {
                    SqlConnection connection = GlobalClass.OpenConnection(out message);
                    if (connection != null && string.IsNullOrEmpty(message))
                    {
                        SqlCommand cmd = new SqlCommand("uspPersonUpsert", connection);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@id", Int32.Parse(hdPersonID.Value));
                        cmd.Parameters.AddWithValue("@first_name", txtFirstNameUpdate.Text.Trim());
                        cmd.Parameters.AddWithValue("@last_name", txtLastNameUpdate.Text.Trim());
                        cmd.Parameters.AddWithValue("@state_id", Int32.Parse(ddlStateUpdate.SelectedValue));
                        cmd.Parameters.AddWithValue("@gender", rbGenderUpdate.SelectedValue);
                        cmd.Parameters.AddWithValue("@dob", txtDOBUpdate.Text.Trim());
                        int row = cmd.ExecuteNonQuery();



                    }

                }

                catch (Exception ex)
                {
                    message = ex.Message;

                }
                finally
                {
                    GlobalClass.CloseConnection(out message);
                }
                DataLoad();
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("alert('Records Updated Successfully');");
                sb.Append("$('#editModal').modal('hide');");
                sb.Append(@"</script>");

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "EditHideModalScript", sb.ToString(), false);
            }

        }


        protected void btnAddRecord_Click(object sender, EventArgs e)
        {
            string message = string.Empty;

            if (txtFirstNameAdd.Text == "" || txtLastNameAdd.Text == "" || ddlStateAdd.SelectedIndex < 0 || rbGenderAdd.SelectedIndex < 0 || txtDOBAdd.Text == "")
                {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("alert('Missing information, record not added!');");
                sb.Append("$('#addModal').modal('hide');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);

            }
            else
            { 
            try
            {

                SqlConnection connection = GlobalClass.OpenConnection(out message);
                if (connection != null && string.IsNullOrEmpty(message))
                {
                    SqlCommand cmd = new SqlCommand("uspPersonUpsert", connection);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@first_name", txtFirstNameAdd.Text.Trim());
                    cmd.Parameters.AddWithValue("@last_name", txtLastNameAdd.Text.Trim());
                    cmd.Parameters.AddWithValue("@state_id", ddlStateAdd.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@gender", rbGenderAdd.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@dob", txtDOBAdd.Text.Trim());

                    int row = cmd.ExecuteNonQuery();

                    txtFirstNameAdd.Text = "";
                    txtLastNameAdd.Text = "";
                    ddlStateAdd.SelectedIndex = -1;
                    rbGenderAdd.SelectedIndex = -1;
                    txtDOBAdd.Text = "";
                }


            }

            catch (Exception ex)
            {
                message = ex.Message;

            }
            finally
            {

                GlobalClass.CloseConnection(out message);

            }

            DataLoad();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("alert('Record Added Successfully');");
            sb.Append("$('#addModal').modal('hide');");
            sb.Append(@"</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AddHideModalScript", sb.ToString(), false);
        }
    }
    }
}