module ControlHazard(
    input jump,
    input branch_hazard,
    output control_hazard
);
    
    assign control_hazard = jump || branch_hazard;

endmodule