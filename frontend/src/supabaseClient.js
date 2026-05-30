import { createClient } from "@supabase/supabase-js";

const supabaseUrl = "https://pcwuquhijjthtyczubme.supabase.co";
const supabaseAnonKey = "sb_publishable_qaAB4HkPfEcXZKb46HNfTw_cnqO32xy";

export const supabase = createClient(supabaseUrl, supabaseAnonKey);