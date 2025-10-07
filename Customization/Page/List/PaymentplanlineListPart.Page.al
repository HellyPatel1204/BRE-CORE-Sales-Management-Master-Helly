page 52008 "PaymentplanLineListPart"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "PaymentplanLine";
    Caption = 'Payment Plan Line';

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
                field("Installment Stages"; Rec."Installment Stages")
                {
                    ToolTip = 'Installment Stages';
                    Lookup = true;
                }
                field("Percentage"; Rec."Percentage")
                {
                    ToolTip = 'Percentage';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Entry No.';
                }
            }
        }
    }
}
