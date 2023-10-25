
module Postgres = struct
  include Petrol.Postgres
  let uuid = Petrol.Type.custom ~ty:Caqti_type.string ~repr:"UUID"
  let timestamptz = Petrol.Type.custom ~ty:Caqti_type.ptime ~repr:"timestamptz"
end

module ReportsTbl = struct
  open Petrol.VersionedSchema

  let v_0_1_0 = version [0;1;0]
  let v_0_1_1 = version [0;1;1]

  let s = init v_0_1_1 ~name:"public"

  let name, Petrol.Expr.[id_col; body_col; created_at_col] = 
    let open Postgres in
    let open Petrol.Schema in
    declare_table s ~name:"reports" ~since:v_0_1_0
      [ field "id" ~ty:uuid ~constraints:[ primary_key (); unique (); ]
      ; field "body" ~ty:Postgres.Type.text
      ; field "created_at" ~ty:timestamptz
      ]
      ~migrations:[
        v_0_1_1, [
          Caqti_request.Infix.(Caqti_type.unit ->. Caqti_type.unit)
          {|ALTER TABLE reports
              ALTER id SET DEFAULT uuid_generate_v4()
          |};
          Caqti_request.Infix.(Caqti_type.unit ->. Caqti_type.unit)
          {|ALTER TABLE reports
              ALTER created_at SET DEFAULT CURRENT_TIMESTAMP
          |};
        ]
      ]
  
end


