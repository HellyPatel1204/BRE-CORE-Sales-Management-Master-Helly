page 52010 "PaymentplandetailsCard"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Paymentplandetails;
    Caption = 'Payment Plan Details';
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Plan No"; Rec."Plan No")
                {
                    ToolTip = 'Plan No.';
                }
                field("Plan Name"; Rec."Plan Name")
                {
                    ToolTip = 'Plan Name.';
                }
                field("Description"; Rec."Description")
                {
                    ToolTip = 'Description.';
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Status.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Start Date.';

                    trigger OnValidate()
                    begin
                        UpdateStatus();
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'End Date.';

                    trigger OnValidate()
                    begin
                        UpdateStatus();
                    end;
                }
                field("Down Payment Percentage"; Rec."Down Payment Percentage")
                {
                    ToolTip = 'Down Payment Percentage.';
                }
            }
            group("Property Details")
            {

                field("Property No."; Rec."Property No.")
                {
                    ToolTip = 'Property No.';
                    Lookup = true;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ToolTip = 'Property Name.';
                }
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Project No.';
                    Lookup = true;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ToolTip = 'Project Name.';
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ToolTip = 'Unit Type.';
                    Lookup = true;
                }
                field("Default"; Rec."Default")
                {
                    ToolTip = 'Default';
                }
                field("Property URL"; Rec."Property URL")
                {
                    ToolTip = 'Property URL';
                }
            }

            group("Payment Plan")
            {
                part("Payment Plan Breakdown"; "PaymentplanLineListPart")
                {
                    SubPageLink = "Plan No" = FIELD("Plan No"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        LastRec: Record "Paymentplandetails";
        LastNo: Integer;
        TextNo: Text;
        PaddedNo: Text;
        Prefix: Text[10];
        NumLen: Integer;
    begin
        if Rec."Plan No" = '' then begin
            Prefix := 'PLAN';
            NumLen := 4; // Number of digits (e.g. 0001)

            if LastRec.FindLast() then begin
                // Remove prefix 'PLAN' if exists and get numeric part
                if StrLen(LastRec."Plan No") > StrLen(Prefix) then
                    TextNo := CopyStr(LastRec."Plan No", StrLen(Prefix) + 1)
                else
                    TextNo := '0';

                if Evaluate(LastNo, TextNo) then;
            end else
                LastNo := 0;

            // Manual padding logic (same as PadLeft)
            PaddedNo := Format(LastNo + 1);
            while StrLen(PaddedNo) < NumLen do
                PaddedNo := '0' + PaddedNo;

            Rec."Plan No" := Prefix + PaddedNo;
        end;
    end;

    procedure UpdateStatus()
    begin
        if (Rec."Start Date" <> 0D) and (Rec."End Date" <> 0D) then begin
            if (WorkDate() >= Rec."Start Date") and (WorkDate() <= Rec."End Date") then
                Rec."Status" := Rec."Status"::Activated
            else
                if (WorkDate() > Rec."End Date") then
                    Rec."Status" := Rec."Status"::Deactivated
                else
                    Rec."Status" := Rec."Status"::" "; // not started yet
        end else
            Rec."Status" := Rec."Status"::" ";
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateStatus();
    end;
}
