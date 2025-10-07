page 52009 "PaymentplanList"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Paymentplandetails";
    Caption = 'Payment Plan Details List';
    UsageCategory = Lists;
    CardPageId = 52010;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Plan No"; Rec."Plan No")
                {
                    ToolTip = 'Plan No';
                }
                field("Plan Name"; Rec."Plan Name")
                {
                    ToolTip = 'Name';
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Status';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'End Date';
                }

            }
        }
    }
}
