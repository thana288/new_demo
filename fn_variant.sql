-- FUNCTION: public.fn_variant(character varying, integer, character varying, numeric, boolean, numeric)

-- DROP FUNCTION IF EXISTS public.fn_variant(character varying, integer, character varying, numeric, boolean, numeric);

CREATE OR REPLACE FUNCTION public.fn_variant(
	p_flag character varying,
	p_courseid integer,
	p_varname character varying,
	p_salesprice numeric,
	p_isoffer boolean,
	p_offerpercent numeric)
    RETURNS json
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
Begin
if p_flag='I' then
insert into tbl_variant(courseid,varname,salesprice,isoffer,offerpercent,isactive,createdon,updatedon)values
(p_courseid,p_varname,p_salesprice,P_isoffer,p_offerpercent,true,current_timestamp at time zone 'Asia/kolkata',current_timestamp at time zone 'Asia/kolkata');
return json_build_object('status','S','message','variant created');
end if;
return json_build_object('status','F','message','invalid flag');
exception
when others then
return json_build_object('status','F','error',SQLERRM);
End;
$BODY$;

ALTER FUNCTION public.fn_variant(character varying, integer, character varying, numeric, boolean, numeric)
    OWNER TO postgres;
