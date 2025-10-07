pageextension 51255 "Create Task" extends "Create Task"
{
    layout
    {
        modify("TypeSaaS")
        {
            Visible = false;
        }

        modify("Start Time")
        {
            Enabled = StartTimeEnable;
        }

        modify("Duration")
        {
            Enabled = DurationEnable;
        }

        modify("Ending Time")
        {
            Enabled = EndingTimeEnable;
        }

        addfirst(General)
        {
            field("Custome Type"; Rec."Custome Type")
            {
                ApplicationArea = All;
                Caption = 'Task Type';
                ToolTip = 'Select the type of task to automatically set duration and make time fields editable.';

                trigger OnValidate()
                begin
                    ValidateCustomTaskType();
                    EnableFields();
                    CurrPage.Update(false);
                end;
            }
        }

        addafter("Wizard Contact Name")
        {
            field("Threshold Value"; Rec."Threshold Value")
            {
                ApplicationArea = All;
                Caption = 'Threshold Value';
                ToolTip = 'This value is automatically populated from the selected contact.';
                Editable = false;
                Style = StandardAccent;
            }
            field("Budget Range (AED)"; Rec."Budget Range (AED)")
            {
                ApplicationArea = All;
                Caption = 'Budget Range (AED)';
                ToolTip = 'This value is automatically populated from the selected contact.';
                Editable = false;
                Style = StandardAccent;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EnableFields();
    end;

    trigger OnOpenPage()
    begin
        EnableFields();
    end;

    trigger OnAfterGetRecord()
    begin
        EnableFields();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EnableFields();
    end;

    var
        StartTimeEnable: Boolean;
        EndingTimeEnable: Boolean;
        DurationEnable: Boolean;

    local procedure ValidateCustomTaskType()
    begin
        case Rec."Custome Type" of
            Rec."Custome Type"::Meeting:
                begin
                    Rec."Start Time" := 090000T;
                    Rec.Duration := 30 * 60 * 1000;
                    Rec."All Day Event" := false;
                end;
            Rec."Custome Type"::"Phone Call":
                begin
                    Rec."Start Time" := 100000T;
                    Rec.Duration := 30 * 60 * 1000;
                    Rec."All Day Event" := false;
                end;
            Rec."Custome Type"::"Site Visit":
                begin
                    Rec."Start Time" := 140000T;
                    Rec.Duration := 30 * 60 * 1000;
                    Rec."All Day Event" := false;
                end;
            else begin
                Rec."Start Time" := 090000T;
                Rec.Duration := 30 * 60 * 1000;
                Rec."All Day Event" := false;
            end;
        end;

        CalculateEndingDateTime();
    end;

    local procedure EnableFields()
    begin
        case Rec."Custome Type" of
            Rec."Custome Type"::Meeting:
                begin
                    StartTimeEnable := not Rec."All Day Event";
                    EndingTimeEnable := not Rec."All Day Event";
                    DurationEnable := not Rec."All Day Event";
                end;
            Rec."Custome Type"::"Phone Call":
                begin
                    StartTimeEnable := true;
                    EndingTimeEnable := true;
                    DurationEnable := true;
                end;
            Rec."Custome Type"::"Site Visit":
                begin
                    StartTimeEnable := not Rec."All Day Event";
                    EndingTimeEnable := not Rec."All Day Event";
                    DurationEnable := not Rec."All Day Event";
                end;
            else begin
                StartTimeEnable := false;
                EndingTimeEnable := false;
                DurationEnable := false;
            end;
        end;
    end;

    local procedure CalculateEndingDateTime()
    var
        StartDateTime: DateTime;
        EndDateTime: DateTime;
    begin
        if (Rec.Date <> 0D) and (Rec."Start Time" <> 0T) and (Rec.Duration <> 0) then begin
            StartDateTime := CreateDateTime(Rec.Date, Rec."Start Time");
            EndDateTime := StartDateTime + Rec.Duration;

            Rec."Ending Date" := DT2Date(EndDateTime);
            Rec."Ending Time" := DT2Time(EndDateTime);
        end;
    end;
}