page 52011 "PaymentplanStageList"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "PaymentplanStages";
    Caption = 'Payment Plan Stage List';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ToolTip = 'ID';
                }
                field("Installment Stages"; Rec."Installment Stages")
                {
                    ToolTip = 'Installment Stages';
                }
            }
        }
    }
}
