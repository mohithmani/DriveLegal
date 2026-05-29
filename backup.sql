--
-- PostgreSQL database dump
--

\restrict qSa2WxlJqRCjMha0lXgFIWg0kriitZ1vTmyJaVupgGzmvZ0wq30l6Z7bbpmy0vt

-- Dumped from database version 17.10
-- Dumped by pg_dump version 17.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rule" (
    id integer NOT NULL,
    violation text NOT NULL,
    fine text NOT NULL,
    "stateId" integer NOT NULL
);


ALTER TABLE public."Rule" OWNER TO postgres;

--
-- Name: Rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rule_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Rule_id_seq" OWNER TO postgres;

--
-- Name: Rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rule_id_seq" OWNED BY public."Rule".id;


--
-- Name: State; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."State" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."State" OWNER TO postgres;

--
-- Name: State_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."State_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."State_id_seq" OWNER TO postgres;

--
-- Name: State_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."State_id_seq" OWNED BY public."State".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: traffic_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_questions (
    id integer NOT NULL,
    question text NOT NULL,
    option_a text NOT NULL,
    option_b text NOT NULL,
    option_c text NOT NULL,
    option_d text NOT NULL,
    correct_answer character varying(5) NOT NULL,
    state_name character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.traffic_questions OWNER TO postgres;

--
-- Name: traffic_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.traffic_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.traffic_questions_id_seq OWNER TO postgres;

--
-- Name: traffic_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.traffic_questions_id_seq OWNED BY public.traffic_questions.id;


--
-- Name: traffic_quiz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_quiz (
    id integer NOT NULL,
    question text NOT NULL,
    option_a text NOT NULL,
    option_b text NOT NULL,
    option_c text NOT NULL,
    option_d text NOT NULL,
    correct_answer character(1) NOT NULL,
    state_name text DEFAULT 'ALL'::text,
    CONSTRAINT traffic_quiz_correct_answer_check CHECK ((correct_answer = ANY (ARRAY['A'::bpchar, 'B'::bpchar, 'C'::bpchar, 'D'::bpchar])))
);


ALTER TABLE public.traffic_quiz OWNER TO postgres;

--
-- Name: traffic_quiz_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.traffic_quiz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.traffic_quiz_id_seq OWNER TO postgres;

--
-- Name: traffic_quiz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.traffic_quiz_id_seq OWNED BY public.traffic_quiz.id;


--
-- Name: traffic_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_rules (
    id integer NOT NULL,
    state_name character varying(100) NOT NULL,
    violation character varying(255) NOT NULL,
    fine_amount character varying(100),
    description text
);


ALTER TABLE public.traffic_rules OWNER TO postgres;

--
-- Name: traffic_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.traffic_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.traffic_rules_id_seq OWNER TO postgres;

--
-- Name: traffic_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.traffic_rules_id_seq OWNED BY public.traffic_rules.id;


--
-- Name: traffic_violations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_violations (
    id integer NOT NULL,
    state_name text,
    offence_name text,
    normalized_name text,
    category text,
    section text,
    severity text,
    first_offence_fine integer,
    repeat_offence_fine integer,
    description text,
    keywords text
);


ALTER TABLE public.traffic_violations OWNER TO postgres;

--
-- Name: traffic_violations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.traffic_violations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.traffic_violations_id_seq OWNER TO postgres;

--
-- Name: traffic_violations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.traffic_violations_id_seq OWNED BY public.traffic_violations.id;


--
-- Name: Rule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rule" ALTER COLUMN id SET DEFAULT nextval('public."Rule_id_seq"'::regclass);


--
-- Name: State id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."State" ALTER COLUMN id SET DEFAULT nextval('public."State_id_seq"'::regclass);


--
-- Name: traffic_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_questions ALTER COLUMN id SET DEFAULT nextval('public.traffic_questions_id_seq'::regclass);


--
-- Name: traffic_quiz id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_quiz ALTER COLUMN id SET DEFAULT nextval('public.traffic_quiz_id_seq'::regclass);


--
-- Name: traffic_rules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_rules ALTER COLUMN id SET DEFAULT nextval('public.traffic_rules_id_seq'::regclass);


--
-- Name: traffic_violations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_violations ALTER COLUMN id SET DEFAULT nextval('public.traffic_violations_id_seq'::regclass);


--
-- Data for Name: Rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Rule" (id, violation, fine, "stateId") FROM stdin;
\.


--
-- Data for Name: State; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."State" (id, name) FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
3b3739ab-73fe-4119-8ee8-0b90be96c088	8485416f5632a8335d3a23a28a9356af4522b2731cb22f7a39669bab70e0bfea	2026-05-27 19:46:10.506959+05:30	20260527141610_init	\N	\N	2026-05-27 19:46:10.492674+05:30	1
\.


--
-- Data for Name: traffic_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.traffic_questions (id, question, option_a, option_b, option_c, option_d, correct_answer, state_name, created_at) FROM stdin;
1	What is the fine for driving a two-wheeler without a helmet in India for the first offence?	₹500	₹1000	₹2000	₹5000	B	India	2026-05-29 09:35:43.902193
2	Is wearing a helmet mandatory for both the rider and pillion passenger in India?	Only for the rider	Only for the pillion	Yes, for both rider and pillion	Only on highways	C	India	2026-05-29 09:35:43.907085
3	What is the fine for a first-time seat belt violation in India?	₹500	₹1000	₹2000	₹3000	B	India	2026-05-29 09:35:43.908742
4	What is the penalty for driving without a valid licence in India for the first offence?	₹1000	₹2000	₹5000	₹10000	C	India	2026-05-29 09:35:43.909823
5	What is the first offence fine for driving without vehicle insurance in India?	₹1000	₹2000	₹3000	₹5000	B	India	2026-05-29 09:35:43.911435
6	What is the fine for jumping a red light in India for the first offence?	₹1000	₹2000	₹5000	₹10000	C	India	2026-05-29 09:35:43.912966
7	What is the first offence fine for using a mobile phone while driving in India?	₹1000	₹2000	₹5000	₹8000	C	India	2026-05-29 09:35:43.914034
8	What is the penalty for drunk driving in India for the first offence?	₹2000	₹5000	₹10000	₹15000	C	India	2026-05-29 09:35:43.915069
9	What is the first offence fine for overspeeding in India?	₹1000	₹2000	₹3000	₹5000	B	India	2026-05-29 09:35:43.916184
10	What is the first offence fine for dangerous driving in India?	₹5000	₹8000	₹10000	₹15000	C	India	2026-05-29 09:35:43.917048
11	What is the first offence fine for triple riding on a two-wheeler in India?	₹500	₹1000	₹2000	₹5000	B	India	2026-05-29 09:35:43.918147
12	What is the first offence fine for wrong side driving in India?	₹1000	₹2000	₹5000	₹10000	C	India	2026-05-29 09:35:43.920213
13	What is the first offence fine for driving without a valid Pollution Under Control Certificate (PUCC)?	₹5000	₹8000	₹10000	₹15000	C	India	2026-05-29 09:35:43.921443
14	What is the first offence fine for illegal parking in India?	₹100	₹300	₹500	₹1000	C	India	2026-05-29 09:35:43.923063
15	What is the first offence fine for a lane discipline violation in India?	₹200	₹500	₹1000	₹2000	B	India	2026-05-29 09:35:43.924438
16	What is the first offence fine for using a pressure horn in India?	₹2000	₹3000	₹5000	₹8000	C	India	2026-05-29 09:35:43.927261
17	What is the first offence fine for using tinted glass on a vehicle in India?	₹200	₹500	₹1000	₹2000	B	India	2026-05-29 09:35:43.928437
18	Which document confirms that a vehicle has passed the pollution emission test?	Registration Certificate	Pollution Under Control Certificate (PUCC)	Driving Licence	Vehicle Insurance Policy	B	India	2026-05-29 09:35:43.929855
19	What does RC stand for in vehicle documentation?	Road Certificate	Route Card	Registration Certificate	Renewal Certificate	C	India	2026-05-29 09:35:43.931029
20	Which ministry governs road transport rules in India?	Ministry of Home Affairs	Ministry of Road Transport and Highways	Ministry of Urban Development	Ministry of Finance	B	India	2026-05-29 09:35:43.932814
21	What is the permissible Blood Alcohol Concentration (BAC) limit for drivers in India?	50mg per 100ml of blood	40mg per 100ml of blood	30mg per 100ml of blood	10mg per 100ml of blood	C	India	2026-05-29 09:35:43.93507
22	Is hand-held mobile phone usage prohibited while driving in India?	No, it is allowed	Only prohibited on highways	Yes, it is prohibited	Only for commercial vehicle drivers	C	India	2026-05-29 09:35:43.936384
23	Which act primarily governs motor vehicle offences in India?	Indian Penal Code 1860	Motor Vehicles Act 1988	Road Safety Act 1980	Transport Laws Act 1972	B	India	2026-05-29 09:35:43.937662
24	In which year was the Motor Vehicles Act amended to increase traffic penalties?	2015	2017	2019	2021	C	India	2026-05-29 09:35:43.938902
25	Which online portal is used to pay traffic challans in India?	parivahan.gov.in	echallan.parivahan.gov.in	rto.gov.in	trafficfine.gov.in	B	India	2026-05-29 09:35:43.940983
26	What is the purpose of the Parivahan portal in India?	Filing income tax returns	Vehicle and driving licence related services	Applying for Aadhaar card	Booking railway tickets	B	India	2026-05-29 09:35:43.943229
27	Which body issues driving licences in India?	Traffic Police Department	Regional Transport Office (RTO)	Ministry of Home Affairs	National Highway Authority	B	India	2026-05-29 09:35:43.944768
28	How many documents are listed as mandatory to carry while driving in India?	2	3	4	5	C	India	2026-05-29 09:35:43.946041
29	What is a traffic challan?	A vehicle registration form	An official notice of a traffic violation fine	A driving test certificate	A highway toll receipt	B	India	2026-05-29 09:35:43.948246
30	Is seat belt mandatory for rear seat passengers in India?	No, only front seat passengers	Yes, for all passengers	Only on highways	Only for children	B	India	2026-05-29 09:35:43.95111
31	What is wrong side driving?	Driving on a broken road	Driving in the opposite direction of traffic flow	Driving without headlights	Driving over the speed limit	B	India	2026-05-29 09:35:43.952346
32	What does a traffic signal's red light indicate?	Drive faster	Slow down gradually	Stop the vehicle completely	Honk and proceed	C	India	2026-05-29 09:35:43.953361
33	What is triple riding?	Three vehicles driving in a convoy	Three people riding on a two-wheeler	Riding at three times the speed limit	Riding with three bags on a bike	B	India	2026-05-29 09:35:43.955193
34	Which of the following is a traffic violation in India?	Using seat belt	Carrying RC book	Driving without a valid driving licence	Wearing helmet	C	India	2026-05-29 09:35:43.957152
35	What kind of vehicles require a PUCC certificate in India?	Only trucks and buses	Only two-wheelers	All motor vehicles	Only vehicles older than 10 years	C	India	2026-05-29 09:35:43.958516
36	What is dangerous driving?	Driving without music	Driving in a manner that endangers other road users	Driving on a rainy day	Driving at exactly the speed limit	B	India	2026-05-29 09:35:43.959374
37	What is the full form of PUCC?	Public Urban Compliance Certificate	Pollution Under Control Certificate	Petrol Usage Control Certificate	Private Urban Car Certificate	B	India	2026-05-29 09:35:43.960877
38	What is the full form of MoRTH?	Ministry of Roads and Transport Hub	Ministry of Road Transport and Highways	Management of Road Traffic and Highways	Motor Road Transport and Highway	B	India	2026-05-29 09:35:43.963538
39	Which of the following is NOT a mandatory document to carry while driving in India?	Driving Licence	Vehicle Insurance	Aadhaar Card	RC Book	C	India	2026-05-29 09:35:43.965429
40	What is a lane violation?	Driving too slowly in any lane	Failing to follow designated lane rules while driving	Not using the horn while changing lanes	Driving in a lane with no vehicles	B	India	2026-05-29 09:35:43.966698
41	What is illegal parking?	Parking in your own garage	Parking in a designated parking zone	Parking in a restricted or prohibited area	Parking at night	C	India	2026-05-29 09:35:43.968607
42	Why is vehicle insurance mandatory in India?	To increase vehicle resale value	To provide financial protection in case of accident or damage	To qualify for a driving licence	To avoid paying road tax	B	India	2026-05-29 09:35:43.971372
43	What is overspeeding?	Driving faster than the engine allows	Driving beyond the legally permitted speed limit	Driving faster than other vehicles on the road	Driving on an empty road at any speed	B	India	2026-05-29 09:35:43.972765
44	What is the primary reason for banning tinted glass beyond permissible limits on vehicles?	It makes the vehicle look unattractive	It reduces fuel efficiency	It hinders visibility and law enforcement checks	It increases the vehicle's weight	C	India	2026-05-29 09:35:43.974019
45	What is a pressure horn?	A horn powered by electricity	A loud horn that exceeds permissible sound limits	A horn used only in emergency vehicles	A horn used only on buses	B	India	2026-05-29 09:35:43.978769
46	Which regulatory body manages the VAHAN portal in India?	NHAI	MoRTH through Parivahan	State Traffic Police	Ministry of Home Affairs	B	India	2026-05-29 09:35:43.980072
47	At what minimum age can a person apply for a driving licence for a motor vehicle in India?	16 years	18 years	21 years	25 years	B	India	2026-05-29 09:35:43.981105
48	What does e-challan mean?	A paper fine receipt	An electronic traffic violation notice issued digitally	A toll fee slip	An email from the transport office	B	India	2026-05-29 09:35:43.983047
49	What happens if you drive without a valid RC book in India?	You get a free pass	You can be fined for a traffic violation	Only a verbal warning is given	Nothing happens	B	India	2026-05-29 09:35:43.98489
50	What is the main purpose of a driving licence?	To identify the vehicle owner	To prove the vehicle has passed an emission test	To certify that a person is legally permitted to drive	To pay road tax	C	India	2026-05-29 09:35:43.986379
51	Which of these is considered a road safety violation in India?	Checking mirrors before changing lanes	Stopping at a zebra crossing for pedestrians	Jumping a red traffic signal	Wearing a seat belt while driving	C	India	2026-05-29 09:35:43.987735
52	What action should a driver take when they see a yellow traffic light?	Speed up to cross before it turns red	Honk continuously	Prepare to stop as it is about to turn red	Switch to the other lane	C	India	2026-05-29 09:35:43.989589
53	Which vehicle type is most commonly associated with triple riding violations?	Cars	Two-wheelers	Buses	Trucks	B	India	2026-05-29 09:35:43.991849
54	What is the penalty for a first-time offence of illegal parking in India?	No fine, only warning	₹100	₹500	₹2000	C	India	2026-05-29 09:35:43.993509
55	What should you do if your vehicle's PUCC certificate expires?	Continue driving until police stop you	Get the vehicle retested and renew the certificate	Apply for a new RC book	Contact your vehicle insurance company	B	India	2026-05-29 09:35:43.994641
56	Which of these actions is legally permitted while driving in India?	Using a handheld mobile phone	Driving after consuming alcohol beyond BAC limit	Using a hands-free device for calls	Triple riding on a two-wheeler	C	India	2026-05-29 09:35:43.996178
57	What does a green traffic signal mean?	Stop immediately	Slow down and proceed with caution	Proceed normally as the way is clear	Honk and overtake	C	India	2026-05-29 09:35:43.997561
58	Which of these is a document-related traffic violation in India?	Overspeeding	Triple riding	Driving without valid insurance	Lane violation	C	India	2026-05-29 09:35:43.999982
59	What is the repeat offence fine for using a mobile phone while driving in India?	₹5000	₹8000	₹10000	The same as first offence — ₹5000	A	India	2026-05-29 09:35:44.001427
60	Which authority enforces traffic rules on the roads in India?	State Traffic Police	Ministry of Finance	NHAI	Income Tax Department	A	India	2026-05-29 09:35:44.002544
61	What is the repeat offence fine for illegal parking in India?	₹500	₹800	₹1000	₹2000	C	India	2026-05-29 09:35:44.003998
62	Can a traffic challan be paid online in India?	No, only at the police station	Yes, through the echallan portal	Only in metro cities	Only for two-wheelers	B	India	2026-05-29 09:35:44.006267
63	What is the purpose of lane markings on roads?	To decorate the road surface	To guide and organise traffic flow safely	To mark parking areas	To show speed limits	B	India	2026-05-29 09:35:44.007564
64	Which traffic violation poses the greatest risk to other road users?	Illegal parking	Tinted glass	Wrong side driving	Lane violation	C	India	2026-05-29 09:35:44.008703
65	Is it legal to modify a vehicle with a pressure horn in India?	Yes, if the vehicle is a bus	Yes, if the vehicle is a truck	No, it is a traffic violation	Yes, for all private vehicles	C	India	2026-05-29 09:35:44.010282
66	What does a traffic challan number help you do?	Register your vehicle	Track and pay your pending traffic fine	Renew your driving licence	Apply for a PUCC certificate	B	India	2026-05-29 09:35:44.011473
67	How should a driver safely handle a mobile phone call while driving?	Hold the phone with one hand and steer with the other	Pull over safely before taking the call	Use speaker mode while holding the phone on the dashboard	Slow down and use the phone normally	B	India	2026-05-29 09:35:44.012988
68	What is the repeat offence fine for dangerous driving in India?	₹10000	₹15000	₹20000	₹25000	C	India	2026-05-29 09:35:44.014769
69	For which offence can a driver's licence be suspended in India?	Illegal parking	Tinted glass	Drunk driving	Lane violation	C	India	2026-05-29 09:35:44.015965
70	A driver is caught for overspeeding twice in India. The first fine is ₹2000 and the repeat fine is ₹4000. What is the total fine paid?	₹4000	₹6000	₹8000	₹10000	B	India	2026-05-29 09:35:44.01755
71	What is the repeat offence fine for drunk driving in India?	₹10000	₹15000	₹20000	₹25000	A	India	2026-05-29 09:35:44.019174
72	For a first offence of driving without a licence (₹5000) and driving without insurance (₹2000) together, what is the combined fine?	₹5000	₹7000	₹8000	₹10000	B	India	2026-05-29 09:35:44.02045
73	Which traffic violation carries the highest first offence fine in India — dangerous driving, drunk driving, or no PUCC?	Dangerous driving (₹10000)	Drunk driving (₹10000)	No PUCC (₹10000)	All three are equal at ₹10000	D	India	2026-05-29 09:35:44.021733
74	Can a court challan be issued for dangerous driving in India?	No, only a fine is imposed	Yes, a court challan is possible	Only for commercial vehicles	Only if it results in an accident	B	India	2026-05-29 09:35:44.02313
75	A driver commits triple riding (₹1000 first offence) and no helmet (₹1000 first offence) at the same time. What is the combined fine?	₹1000	₹1500	₹2000	₹3000	C	India	2026-05-29 09:35:44.024713
76	What is the repeat offence fine for overspeeding in India?	₹2000	₹3000	₹4000	₹5000	C	India	2026-05-29 09:35:44.026478
77	For which traffic offence is both a court challan AND licence suspension possible in India?	Illegal parking	Tinted glass	Drunk driving	Triple riding	C	India	2026-05-29 09:35:44.027926
78	What is the repeat offence fine for triple riding in India?	₹1000	₹1500	₹2000	₹3000	C	India	2026-05-29 09:35:44.028979
79	A driver receives fines for jumping a red light (₹5000) and wrong side driving (₹5000). What is the total fine?	₹5000	₹8000	₹10000	₹15000	C	India	2026-05-29 09:35:44.030667
80	Is licence suspension possible for a first-time overspeeding offence in India?	No, only a fine is issued	Yes, licence can be suspended	Only for repeat offenders	Only for commercial vehicle drivers	B	India	2026-05-29 09:35:44.03243
81	What is the repeat offence fine for driving without a licence in India?	₹5000	₹8000	₹10000	₹15000	C	India	2026-05-29 09:35:44.034445
119	Which violation carries the lowest first offence fine in India?	Triple riding	Tinted glass	Helmet violation	Lane violation	B	India	2026-05-29 09:35:44.094941
82	For which category of violation does the first offence fine equal the repeat offence fine for no PUCC in India?	No PUCC — both first and repeat are ₹10000	No PUCC — first is ₹10000, repeat is ₹20000	No PUCC — first is ₹5000, repeat is ₹10000	No PUCC — both are ₹5000	A	India	2026-05-29 09:35:44.036096
83	Can a court challan be issued for jumping a red light in India?	No	Yes	Only in metro cities	Only for commercial vehicles	B	India	2026-05-29 09:35:44.037853
84	What is the repeat offence fine for seat belt violation in India?	₹1000	₹1500	₹2000	₹3000	C	India	2026-05-29 09:35:44.040923
85	Which offence carries both the risk of a court challan AND licence suspension for its first offence in India — drunk driving or illegal parking?	Only illegal parking	Only drunk driving	Both drunk driving and illegal parking	Neither	B	India	2026-05-29 09:35:44.042712
86	What is the repeat offence fine for driving without insurance in India?	₹1000	₹2000	₹3000	₹5000	B	India	2026-05-29 09:35:44.044248
87	A driver commits dangerous driving as a repeat offence (₹20000) and uses a pressure horn (₹5000 first offence). What is the total fine?	₹20000	₹22000	₹25000	₹30000	C	India	2026-05-29 09:35:44.045855
88	Is a court challan possible for a lane violation in India?	No	Yes	Only in city limits	Only for heavy vehicles	B	India	2026-05-29 09:35:44.047923
89	What is the repeat offence fine for wrong side driving in India?	₹5000	₹8000	₹10000	₹15000	C	India	2026-05-29 09:35:44.049359
90	For which offence is licence suspension NOT possible in India — tinted glass or drunk driving?	Tinted glass (no suspension)	Drunk driving (no suspension)	Both have possible suspension	Neither has suspension	A	India	2026-05-29 09:35:44.050922
91	What is the repeat offence fine for tinted glass in India?	₹300	₹500	₹1000	₹2000	B	India	2026-05-29 09:35:44.052885
92	A first-time driver is caught without helmet (₹1000), without insurance (₹2000), and driving without licence (₹5000). What is the total fine?	₹6000	₹7000	₹8000	₹10000	C	India	2026-05-29 09:35:44.055213
93	Can a licence be suspended for lane violation in India?	No	Yes	Only if it causes an accident	Only for commercial drivers	B	India	2026-05-29 09:35:44.056392
94	What is the repeat offence fine for jumping a red light in India?	₹3000	₹5000	₹8000	₹10000	B	India	2026-05-29 09:35:44.057377
95	How many times higher is the repeat offence fine for dangerous driving compared to the first offence fine?	Same — no increase	1.5 times higher	2 times higher	3 times higher	C	India	2026-05-29 09:35:44.05891
96	Is a court challan possible for driving without a licence in India?	No	Yes	Only for minors	Only for repeat offenders	B	India	2026-05-29 09:35:44.060659
97	What is the total fine if a driver is fined for overspeeding (₹2000) and no PUCC (₹10000) both for first offence?	₹10000	₹12000	₹14000	₹15000	B	India	2026-05-29 09:35:44.062193
98	Which offence has the same fine for both first and repeat violations — tinted glass or drunk driving?	Tinted glass (both ₹500)	Drunk driving (both ₹10000)	Both have equal first and repeat fines	Neither — both have different fines	A	India	2026-05-29 09:35:44.064305
99	Is licence suspension possible for wrong side driving in India?	No	Yes	Only on national highways	Only for buses and trucks	B	India	2026-05-29 09:35:44.065715
100	A driver receives repeat fines for both overspeeding (₹4000) and seat belt violation (₹2000). What is the combined fine?	₹4000	₹5000	₹6000	₹8000	C	India	2026-05-29 09:35:44.067666
101	For which offences can licence suspension happen in India — only for violations involving vehicles, or also for document offences?	Only driving behaviour violations	Also for document-related violations like driving without insurance	Only for drunk driving	Only for speed-related violations	B	India	2026-05-29 09:35:44.069438
102	What is the repeat offence fine for pressure horn usage in India?	₹3000	₹5000	₹8000	₹10000	B	India	2026-05-29 09:35:44.070892
103	Which pair of violations both carry a ₹5000 first offence fine in India?	Mobile phone and triple riding	Jumping red light and mobile phone	Overspeeding and seat belt	No PUCC and tinted glass	B	India	2026-05-29 09:35:44.072458
104	Can a driver's licence be suspended for dangerous driving in India?	No	Yes	Only after three offences	Only if someone is injured	A	India	2026-05-29 09:35:44.074141
105	What is the combined first offence fine for triple riding (₹1000) and wrong side driving (₹5000)?	₹5000	₹6000	₹7000	₹8000	B	India	2026-05-29 09:35:44.076011
106	For which of these violations is a court challan NOT possible in India — triple riding or drunk driving?	Triple riding	Drunk driving	Both allow court challans	Neither allows court challans	A	India	2026-05-29 09:35:44.077187
107	How does the repeat offence fine for driving without a licence compare to the first offence fine in India?	It stays the same at ₹5000	It doubles to ₹10000	It triples to ₹15000	It halves to ₹2500	B	India	2026-05-29 09:35:44.079377
108	Which violation has both the highest first offence fine AND court challan possible — no PUCC or tinted glass?	No PUCC (₹10000, no court challan)	Tinted glass (₹500, court challan possible)	No PUCC (₹10000, court challan possible in some cases)	Both are ₹500 first fine	C	India	2026-05-29 09:35:44.08147
109	What is the repeat offence fine for no PUCC in India?	₹5000	₹8000	₹10000	₹15000	C	India	2026-05-29 09:35:44.083108
110	Can a licence be suspended for driving without a licence in India?	No — you cannot suspend what does not exist	Yes — it can restrict future licence eligibility	Only for minors	Only for commercial drivers	B	India	2026-05-29 09:35:44.084177
111	A driver is fined for drunk driving (₹10000 first offence) and dangerous driving (₹10000 first offence). Both court challans are issued. What is the minimum total fine?	₹10000	₹15000	₹20000	₹25000	C	India	2026-05-29 09:35:44.085204
112	What is the repeat offence fine for helmet violation in India?	₹1000	₹1500	₹2000	₹3000	C	India	2026-05-29 09:35:44.086589
113	Is licence suspension possible for using a mobile phone while driving in India?	No	Yes	Only for taxi and auto-rickshaw drivers	Only for repeat offences	B	India	2026-05-29 09:35:44.087629
114	Which two violations together amount to a ₹6000 fine if both are first offences — triple riding + seat belt, or overspeeding + tinted glass?	Triple riding (₹1000) + seat belt (₹1000) = ₹2000	Overspeeding (₹2000) + tinted glass (₹500) = ₹2500	Triple riding (₹1000) + wrong side driving (₹5000) = ₹6000	Overspeeding (₹2000) + seat belt (₹1000) = ₹3000	C	India	2026-05-29 09:35:44.089043
115	What is the repeat offence fine for lane violation in India?	₹300	₹500	₹800	₹1000	D	India	2026-05-29 09:35:44.090359
116	For which offence in India is the repeat fine the same as the first fine — overspeeding or tinted glass?	Overspeeding (both ₹2000 in some states)	Tinted glass (both ₹500)	Both have different first and repeat fines	Neither has the same fine	B	India	2026-05-29 09:35:44.091218
117	Can a court challan be issued for drunk driving in India?	No, only a fine is levied	Yes, a court challan can be issued	Only if BAC is above 60mg	Only for commercial drivers	B	India	2026-05-29 09:35:44.092155
118	What is the combined repeat offence fine for overspeeding (₹4000) and wrong side driving (₹10000)?	₹10000	₹12000	₹14000	₹16000	C	India	2026-05-29 09:35:44.09362
120	Is it possible for AI cameras to issue traffic challans automatically in India?	No, only police officers can issue challans	Yes, AI camera-based enforcement is enabled in many states	Only in Delhi and Mumbai	Only for speed violations	B	India	2026-05-29 09:35:44.096852
121	A driver gets fines for no helmet (₹1000), no insurance (₹2000), and no PUCC (₹10000) for first offences. What is the combined fine?	₹11000	₹12000	₹13000	₹15000	C	India	2026-05-29 09:35:44.098356
122	For which traffic offence in India does the repeat fine go up to ₹20000?	Overspeeding	Triple riding	Dangerous driving	Seat belt violation	C	India	2026-05-29 09:35:44.099475
123	What is the difference between the repeat and first offence fine for driving without a licence in India?	₹2000 difference	₹5000 difference	No difference	₹10000 difference	B	India	2026-05-29 09:35:44.100919
124	Which violation carries the same ₹10000 fine for both dangerous driving and drunk driving in India?	Only the first offence fine is equal for both	Only the repeat fine is equal for both	Both first offence fines are ₹10000	The repeat fines are different	C	India	2026-05-29 09:35:44.102462
125	In India, which pair of violations both allow licence suspension for first offences?	Helmet violation and tinted glass	Dangerous driving and tinted glass	Drunk driving and overspeeding	Triple riding and lane violation	C	India	2026-05-29 09:35:44.103878
126	What is the total fine for a driver caught for seat belt violation (₹1000 first offence) and lane violation (₹500 first offence)?	₹1000	₹1500	₹2000	₹2500	B	India	2026-05-29 09:35:44.105123
127	Is licence suspension possible for a first-time illegal parking offence in India?	No	Yes	Only if it blocks emergency services	Only in no-parking zones	B	India	2026-05-29 09:35:44.10669
128	How much more is the repeat fine for dangerous driving compared to the first offence fine in India?	₹5000 more	₹10000 more	₹15000 more	Same amount	B	India	2026-05-29 09:35:44.108337
129	Can a court challan be issued for a tinted glass violation in India?	No	Yes	Only for imported vehicles	Only for vehicles with factory-fitted tint	A	India	2026-05-29 09:35:44.110101
130	What is the combined first offence fine for drunk driving (₹10000) and no PUCC (₹10000)?	₹10000	₹15000	₹20000	₹25000	C	India	2026-05-29 09:35:44.111614
131	For how many violation categories in India is the repeat fine DOUBLE the first offence fine?	2 categories	3 categories	4 categories	5 categories	C	India	2026-05-29 09:35:44.112779
132	In India, which violation has the largest gap between its first and repeat offence fines?	Overspeeding (₹2000 gap)	Dangerous driving (₹10000 gap)	Drunk driving (₹0 gap)	Helmet violation (₹1000 gap)	B	India	2026-05-29 09:35:44.1148
133	Is licence suspension possible for a pressure horn violation in India?	No	Yes	Only for buses and trucks	Only for repeat offences	B	India	2026-05-29 09:35:44.116656
134	What is the total fine for a driver caught for triple riding (₹1000), no helmet (₹1000), and no PUCC (₹10000) all as first offences?	₹10000	₹11000	₹12000	₹13000	C	India	2026-05-29 09:35:44.118119
135	A driver is caught for dangerous driving (first offence ₹10000), drunk driving (first offence ₹10000), and jumping a red light (repeat offence ₹5000). What is the combined total fine?	₹20000	₹22000	₹25000	₹30000	C	India	2026-05-29 09:35:44.119062
136	For how many of the 16 listed traffic violations in India is a court challan possible?	5	7	9	11	C	India	2026-05-29 09:35:44.120426
137	Which combination of violations allows BOTH court challan AND licence suspension simultaneously in India?	Tinted glass and illegal parking	Triple riding and lane violation	Drunk driving and jumping red light	Tinted glass and triple riding	C	India	2026-05-29 09:35:44.122151
138	A driver is a repeat offender for overspeeding (₹4000), drunk driving (₹10000), and seat belt violation (₹2000). What is the total fine and how many allow court challans?	₹16000 total; 2 allow court challans	₹16000 total; 1 allows court challan	₹14000 total; 2 allow court challans	₹16000 total; all 3 allow court challans	B	India	2026-05-29 09:35:44.12476
139	Across all 16 listed violations in India, which violation category has the highest combined (first + repeat) total fine?	Drunk driving (₹10000 + ₹10000 = ₹20000)	No PUCC (₹10000 + ₹10000 = ₹20000)	Dangerous driving (₹10000 + ₹20000 = ₹30000)	Driving without licence (₹5000 + ₹10000 = ₹15000)	C	India	2026-05-29 09:35:44.125918
140	A driver is fined for all document-related violations (no licence ₹5000, no insurance ₹2000, no PUCC ₹10000) as first offences. What is the total fine and which violations carry court challan risk?	₹17000; only driving without licence	₹17000; all three carry court challan risk	₹17000; driving without licence and no PUCC	₹15000; only no PUCC	A	India	2026-05-29 09:35:44.127353
141	If a driver is caught for ALL of these in one stop — helmet (₹1000), triple riding (₹1000), no insurance (₹2000), and lane violation (₹500) — what is the total fine?	₹3500	₹4000	₹4500	₹5000	C	India	2026-05-29 09:35:44.128886
142	Which scenario results in a higher total fine — a driver caught for drunk driving repeat offence (₹10000) + dangerous driving repeat offence (₹20000), or the same driver caught for no PUCC first offence (₹10000) + driving without licence repeat offence (₹10000) + drunk driving first offence (₹10000)?	First scenario (₹30000) is higher	Second scenario (₹30000) is equal	Second scenario (₹30000) is higher	First scenario (₹30000) and second (₹30000) are equal	D	India	2026-05-29 09:35:44.130528
143	For how many of the 16 traffic violations in India is licence suspension NOT possible?	2 violations	4 violations	6 violations	8 violations	B	India	2026-05-29 09:35:44.132092
144	A driver's first offence total amounts to ₹28500. Which combination produces exactly this amount — (dangerous driving + drunk driving + no PUCC + no helmet)?	₹10000 + ₹10000 + ₹10000 + ₹1000 = ₹31000 (wrong)	₹10000 + ₹10000 + ₹5000 + ₹3500 = ₹28500 (wrong combo)	₹10000 + ₹10000 + ₹10000 + ₹1000 = ₹31000 (doesn't match)	No standard combination from the 16 violations produces exactly ₹28500	D	India	2026-05-29 09:35:44.133204
145	If the court wanted to impose maximum financial penalty on a repeat offender for EVERY violation listed in India, what range would the total fine fall in?	₹50000 to ₹70000	₹80000 to ₹100000	₹100000 to ₹130000	Above ₹130000	C	India	2026-05-29 09:35:44.134304
146	Which set of violations allows licence suspension for first offence but NOT court challan in India?	Overspeeding and wrong side driving	Drunk driving and jumping red light	Triple riding and seat belt violation	Tinted glass and lane violation	A	India	2026-05-29 09:35:44.135731
147	A driver's cumulative fines (all first offences) for all 'Driving' category violations — dangerous driving, drunk driving, mobile phone, wrong side driving — total what amount?	₹25000	₹28000	₹30000	₹35000	C	India	2026-05-29 09:35:44.137488
148	If India's Motor Vehicles Act specifies that courts may double the fine listed for repeat offenders, what would a repeat fine for dangerous driving become above the standard repeat fine of ₹20000?	₹20000	₹30000	₹40000	The act sets a fixed ceiling at ₹20000	C	India	2026-05-29 09:35:44.139029
149	Which pair of violations has the SAME combined (first + repeat) fine in India — (triple riding + seat belt) vs (tinted glass + lane violation)?	Triple riding + seat belt = ₹3000; tinted glass + lane violation = ₹1000	Triple riding + seat belt = ₹3000; tinted glass + lane violation = ₹1500	Both pairs total ₹3000	Both pairs total ₹1500	A	India	2026-05-29 09:35:44.140095
150	For a driver who is both drunk (₹10000) AND driving wrong side (₹5000) AND using mobile phone (₹5000) as first offences — which of these can result in both a court challan AND licence suspension?	All three	Only drunk driving	Drunk driving and mobile phone	Wrong side driving and mobile phone	C	India	2026-05-29 09:35:44.142135
151	What is the ratio of the repeat fine to the first fine for dangerous driving in India?	1:1	1.5:1	2:1	3:1	C	India	2026-05-29 09:35:44.144052
152	A police officer stops a driver for 5 violations — no helmet, no seat belt, no insurance, illegal parking, and no PUCC. All are first offences. What is the total fine the driver must pay?	₹12500	₹13500	₹14000	₹14500	D	India	2026-05-29 09:35:44.146131
153	Which three violations in India when combined as repeat offences total exactly ₹32000?	Dangerous driving (₹20000) + drunk driving (₹10000) + tinted glass (₹500) = ₹30500	Dangerous driving (₹20000) + seat belt (₹2000) + overspeeding (₹4000) = ₹26000	No PUCC (₹10000) + dangerous driving (₹20000) + seat belt (₹2000) = ₹32000	Drunk driving (₹10000) + dangerous driving (₹20000) + helmet (₹2000) = ₹32000	C	India	2026-05-29 09:35:44.148433
154	In India, how many of the 16 listed violations have a repeat fine that is exactly DOUBLE the first offence fine?	2 violations	3 violations	4 violations	5 violations	C	India	2026-05-29 09:35:44.150443
155	For which set of violations does India impose BOTH the highest financial penalty AND potential imprisonment — dangerous driving or drunk driving?	Dangerous driving only	Drunk driving only	Both dangerous driving and drunk driving	Neither — no imprisonment is listed	C	India	2026-05-29 09:35:44.152367
156	A driver is caught for all 'Documents' violations (driving without licence, without insurance, without PUCC) as repeat offences. What is the total fine?	₹17000	₹20000	₹22000	₹25000	C	India	2026-05-29 09:35:44.153762
157	Which combination of first offence violations results in a fine of exactly ₹15000 in India?	No PUCC (₹10000) + overspeeding (₹2000) + triple riding (₹1000) + tinted glass (₹500) + lane (₹500) + helmet (₹1000) = ₹15000	Drunk driving (₹10000) + licence (₹5000) = ₹15000	Dangerous driving (₹10000) + seat belt (₹1000) + insurance (₹2000) + lane (₹500) + tinted (₹500) + helmet (₹1000) = ₹15000	Both B and C produce ₹15000	D	India	2026-05-29 09:35:44.15526
158	Under the Motor Vehicles Amendment Act 2019, which category of violations saw the most significant increase in penalties compared to the original 1988 Act?	Parking violations	Document violations	Safety violations like helmet, seat belt, drunk driving	Noise pollution violations	C	India	2026-05-29 09:35:44.157082
159	A traffic enforcement system uses AI cameras to detect violations automatically. Which set of violations is best suited for AI camera detection in India?	No PUCC and no insurance (document violations)	No helmet, jumping red light, mobile phone usage, and overspeeding	Illegal parking and lane violation only	Drunk driving and dangerous driving	B	India	2026-05-29 09:35:44.159293
160	If a driver commits every safety-related violation (helmet, seat belt, triple riding, drunk driving, dangerous driving, mobile phone) as first offences, what is the total fine?	₹25000	₹28000	₹30000	₹32000	B	India	2026-05-29 09:35:44.160856
161	Which combination of traffic violations creates the highest total fine if caught once each (first offence) from the 16 listed violations in India?	No PUCC + dangerous driving + drunk driving = ₹30000	Dangerous driving + drunk driving + driving without licence = ₹25000	No PUCC + dangerous driving + drunk driving + driving without licence = ₹35000	All document violations together	C	India	2026-05-29 09:35:44.162215
162	Under Indian traffic law, which scenario legally allows police to both collect an on-spot fine AND pursue court action simultaneously?	Tinted glass violation	Illegal parking in a no-parking zone	Drunk driving with court challan issued	Triple riding at night	C	India	2026-05-29 09:35:44.164098
163	If a driver's licence is suspended for drunk driving AND a court challan is issued, which additional legal consequence can follow in India?	Automatic vehicle confiscation	Possible imprisonment as per the Motor Vehicles Act	Mandatory road safety course only	Vehicle registration cancellation	B	India	2026-05-29 09:35:44.166132
164	For which category of violations does the court challan route allow penalties BEYOND the listed fine amounts in India?	Helmet and seat belt violations	Document violations only	Dangerous driving and drunk driving	Parking and lane violations	C	India	2026-05-29 09:35:44.16774
165	A road safety audit finds that 40% of accidents are caused by overspeeding and 30% by drunk driving. Based on India's penalty structure, which violation is penalised MORE heavily per offence?	Overspeeding (₹2000 first offence)	Drunk driving (₹10000 first offence)	Both are penalised equally	It depends on the state	B	India	2026-05-29 09:35:44.169909
166	A driver with a suspended licence is caught driving again. Which TWO violations are they committing simultaneously?	Reckless driving and no insurance	Driving without a licence and violation of suspension order	Overspeeding and dangerous driving	Tinted glass and no PUCC	B	India	2026-05-29 09:35:44.173665
167	Which set of Indian traffic violations allows ONLY licence suspension (not court challan) for first offence?	Overspeeding and wrong side driving	Dangerous driving and drunk driving	Helmet violation and tinted glass	Seat belt and mobile phone	A	India	2026-05-29 09:35:44.175658
168	Based on the penalty structure, which Indian traffic violation is treated most seriously by law — no PUCC, or driving without a licence?	No PUCC (₹10000 first offence — higher)	Driving without licence (₹5000 first offence — but court challan and suspension possible)	Both are equally serious	Driving without licence is more serious due to court challan and repeat escalation	D	India	2026-05-29 09:35:44.178003
169	What is the total repeat offence fine if a driver is penalised for ALL four lowest-fine violations (helmet ₹2000, triple riding ₹2000, seat belt ₹2000, tinted glass ₹500)?	₹5500	₹6000	₹6500	₹7000	C	India	2026-05-29 09:35:44.180258
170	In India's traffic violation system, which two violations share both an identical first offence fine AND identical repeat offence fine?	Helmet and triple riding (both ₹1000 first, ₹2000 repeat)	Drunk driving and dangerous driving (both ₹10000 first, but different repeat)	No PUCC and drunk driving (both ₹10000 first and repeat)	Jumping red light and mobile phone (both ₹5000 first and repeat)	A	India	2026-05-29 09:35:44.182025
171	If Indian authorities increase all traffic fines by 25%, what would the new first offence fine for dangerous driving be?	₹10000	₹11500	₹12500	₹15000	C	India	2026-05-29 09:35:44.183622
172	A driver is caught by AI cameras for three violations simultaneously. The AI detects no helmet, jumping red light, and using mobile phone. All are first offences. What is the combined fine and how many allow licence suspension?	₹11000 total; 2 allow suspension	₹11000 total; 3 allow suspension	₹7000 total; 2 allow suspension	₹11000 total; all 3 allow suspension	A	India	2026-05-29 09:35:44.185484
173	Under Indian traffic law, a court challan for drunk driving can result in imprisonment. What does this mean for the classification of drunk driving as an offence?	It is a civil offence only	It is a compoundable minor offence	It is a criminal offence beyond just a traffic fine	It only affects your insurance premium	C	India	2026-05-29 09:35:44.187374
174	A vehicle is stopped and found to violate all 'noise and modification' violations (pressure horn ₹5000, tinted glass ₹500) and all 'two-wheeler' violations (no helmet ₹1000, triple riding ₹1000) as first offences. What is the total fine?	₹6000	₹7000	₹7500	₹8000	C	India	2026-05-29 09:35:44.188973
175	If a young driver (18 years old, just got a licence) is caught drunk driving for the first time in India — what is the penalty AND can their licence be suspended?	₹5000 fine; no suspension for new drivers	₹10000 fine; yes, licence suspension is possible	₹10000 fine; no suspension for first-time licence holders	Only a warning for first-time licence holders	B	India	2026-05-29 09:35:44.190831
176	Which statement is TRUE about the relationship between court challans and licence suspension in India?	If a court challan is issued, licence suspension always follows automatically	Court challans and licence suspensions are independent — one does not require the other	Licence suspension can only happen after a court challan	Court challans are issued only after licence suspension	B	India	2026-05-29 09:35:44.193083
177	A transport company's driver is caught for dangerous driving (repeat ₹20000), using mobile phone (repeat ₹5000), and driving without insurance (repeat ₹2000). What is the total fine and how many violations allow court challans?	₹27000 total; 2 allow court challans	₹27000 total; 3 allow court challans	₹27000 total; 1 allows court challan	₹25000 total; 2 allow court challans	C	India	2026-05-29 09:35:44.194724
178	In the context of Indian traffic law, what is the legal significance of a 'repeat offence'?	It means the offence happened twice in one day	It results in higher fines and greater risk of licence suspension and court action	It is treated the same as a first offence	It only applies to commercial vehicle drivers	B	India	2026-05-29 09:35:44.1959
179	A driver is caught on a single journey for overspeeding (first ₹2000), wrong side driving (first ₹5000), and dangerous driving (first ₹10000). Can their licence be suspended for ALL THREE simultaneously?	No — only dangerous driving allows suspension	No — only wrong side driving and overspeeding allow suspension	Yes — all three allow licence suspension	Only if all three happen on a national highway	B	India	2026-05-29 09:35:44.197272
180	What total fine would a driver pay for committing ONLY the violations where the repeat fine is exactly DOUBLE the first fine — if all are charged as repeat offences?	₹22000	₹26000	₹28000	₹30000	C	India	2026-05-29 09:35:44.199023
181	Under Indian traffic law, which enforcement technology combination provides the most comprehensive automated coverage — AI cameras alone, or AI cameras combined with OCR and number plate recognition?	AI cameras alone are sufficient	AI cameras with OCR and number plate recognition covers more violation types	Manual policing is more comprehensive than any technology	Only speed cameras are legally valid	B	India	2026-05-29 09:35:44.201332
182	If India's traffic law system prioritises violations by severity — Critical first, then High, then Medium, then Low — which violation should theoretically receive enforcement attention FIRST?	Tinted glass	Illegal parking	Jumping red light (Critical severity)	Lane violation	C	India	2026-05-29 09:35:44.202677
183	A driver is flagged for the following first offences: no helmet (₹1000), no seat belt (₹1000), no licence (₹5000), no insurance (₹2000), no PUCC (₹10000), and illegal parking (₹500). What is the total fine and how many of these carry court challan risk?	₹19500 total; 1 allows court challan	₹19500 total; 2 allow court challans	₹19500 total; 3 allow court challans	₹18500 total; 2 allow court challans	A	India	2026-05-29 09:35:44.204619
184	Which is the most accurate statement about how India's 2019 Motor Vehicles Amendment changed penalty structures?	It only added new categories of violations	It significantly increased fines and added stricter penalties for safety violations	It removed penalties for minor violations to reduce police harassment	It only changed penalties for commercial vehicle violations	B	India	2026-05-29 09:35:44.207441
185	For a driver who has committed every 'Critical severity' traffic violation in India as first offences, which violations are included and what is the combined fine?	Jumping red light + wrong side driving = ₹10000	Dangerous driving + drunk driving = ₹20000	It varies by state since severity ratings differ	No national standard for severity exists	C	India	2026-05-29 09:35:44.208874
186	In India's AI-powered traffic enforcement system, which violation type requires BOTH visual object detection AND OCR (optical character recognition) to be fully processed?	Helmet violation only	Drunk driving	Number plate-linked violations like overspeeding and red light jumping	Seat belt violation only	C	India	2026-05-29 09:35:44.209991
187	A driver receives challan notices by post. This indicates which type of enforcement system was used?	Manual on-road policing	Automated AI camera system generating e-challans linked to number plates	Court-ordered fines	Insurance-based tracking	B	India	2026-05-29 09:35:44.212358
188	Under the principle of escalating penalties, if India were to introduce a third-offence fine tier at 3x the first offence fine, what would the third-offence fine for dangerous driving be?	₹20000	₹25000	₹30000	₹35000	C	India	2026-05-29 09:35:44.214384
189	Which traffic violation in India creates the most complex legal consequences because it affects BOTH the driver's criminal record (court challan) AND their ability to drive (licence suspension)?	Tinted glass	Triple riding	Drunk driving	Illegal parking	C	India	2026-05-29 09:35:44.216004
190	If a vehicle is involved in an accident while the driver was committing dangerous driving (first offence ₹10000) AND drunk driving (first offence ₹10000), and both court challans are issued — what is the MINIMUM financial liability from traffic fines alone?	₹10000	₹15000	₹20000	₹25000	C	India	2026-05-29 09:35:44.217472
191	Which statement best explains why wrong side driving carries both a high fine AND licence suspension possibility in India?	It causes environmental pollution	It directly endangers oncoming traffic and creates high collision risk	It is difficult to detect automatically	It violates parking regulations	B	India	2026-05-29 09:35:44.219074
192	A traffic court reviews a case where a driver committed drunk driving (first offence), dangerous driving (first offence), and was driving without a licence (first offence). Court challans were issued for all applicable violations. How many court challans can legally be issued simultaneously?	Only 1 court challan at a time	2 court challans (drunk driving and driving without licence)	3 court challans for all three violations	Court challans are only for repeat offenders	B	India	2026-05-29 09:35:44.22134
\.


--
-- Data for Name: traffic_quiz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.traffic_quiz (id, question, option_a, option_b, option_c, option_d, correct_answer, state_name) FROM stdin;
\.


--
-- Data for Name: traffic_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.traffic_rules (id, state_name, violation, fine_amount, description) FROM stdin;
1	country			
2	country			
3	country			
4	country			
5	country			
6	Andhra Pradesh	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
7	Andhra Pradesh	Triple Riding	1000	Triple Riding violation under 194C MVA.
8	Andhra Pradesh	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
9	Andhra Pradesh	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
10	Andhra Pradesh	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
11	Andhra Pradesh	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
12	Andhra Pradesh	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
13	Andhra Pradesh	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
14	Andhra Pradesh	Overspeeding	2000	Overspeeding violation under 183 MVA.
15	Andhra Pradesh	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
16	Andhra Pradesh	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
17	Andhra Pradesh	No PUCC	10000	No PUCC violation under 190(2) MVA.
18	Andhra Pradesh	Tinted Glass	500	Tinted Glass violation under 177 MVA.
19	Andhra Pradesh	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
20	Andhra Pradesh	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
21	Andhra Pradesh	Lane Violation	500	Lane Violation violation under 119/177 MVA.
22	Arunachal Pradesh	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
23	Arunachal Pradesh	Triple Riding	1000	Triple Riding violation under 194C MVA.
24	Arunachal Pradesh	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
25	Arunachal Pradesh	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
26	Arunachal Pradesh	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
27	Arunachal Pradesh	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
28	Arunachal Pradesh	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
29	Arunachal Pradesh	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
30	Arunachal Pradesh	Overspeeding	2000	Overspeeding violation under 183 MVA.
31	Arunachal Pradesh	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
32	Arunachal Pradesh	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
33	Arunachal Pradesh	No PUCC	10000	No PUCC violation under 190(2) MVA.
34	Arunachal Pradesh	Tinted Glass	500	Tinted Glass violation under 177 MVA.
35	Arunachal Pradesh	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
36	Arunachal Pradesh	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
37	Arunachal Pradesh	Lane Violation	500	Lane Violation violation under 119/177 MVA.
38	Assam	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
39	Assam	Triple Riding	1000	Triple Riding violation under 194C MVA.
40	Assam	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
41	Assam	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
42	Assam	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
43	Assam	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
44	Assam	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
45	Assam	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
46	Assam	Overspeeding	2000	Overspeeding violation under 183 MVA.
47	Assam	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
48	Assam	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
49	Assam	No PUCC	10000	No PUCC violation under 190(2) MVA.
50	Assam	Tinted Glass	500	Tinted Glass violation under 177 MVA.
51	Assam	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
52	Assam	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
53	Assam	Lane Violation	500	Lane Violation violation under 119/177 MVA.
54	Bihar	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
55	Bihar	Triple Riding	1000	Triple Riding violation under 194C MVA.
56	Bihar	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
57	Bihar	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
58	Bihar	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
59	Bihar	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
60	Bihar	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
61	Bihar	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
62	Bihar	Overspeeding	2000	Overspeeding violation under 183 MVA.
63	Bihar	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
64	Bihar	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
65	Bihar	No PUCC	10000	No PUCC violation under 190(2) MVA.
66	Bihar	Tinted Glass	500	Tinted Glass violation under 177 MVA.
67	Bihar	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
68	Bihar	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
69	Bihar	Lane Violation	500	Lane Violation violation under 119/177 MVA.
70	Chhattisgarh	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
71	Chhattisgarh	Triple Riding	1000	Triple Riding violation under 194C MVA.
72	Chhattisgarh	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
73	Chhattisgarh	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
289	Nagaland	No PUCC	10000	No PUCC violation under 190(2) MVA.
74	Chhattisgarh	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
75	Chhattisgarh	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
76	Chhattisgarh	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
77	Chhattisgarh	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
78	Chhattisgarh	Overspeeding	2000	Overspeeding violation under 183 MVA.
79	Chhattisgarh	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
80	Chhattisgarh	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
81	Chhattisgarh	No PUCC	10000	No PUCC violation under 190(2) MVA.
82	Chhattisgarh	Tinted Glass	500	Tinted Glass violation under 177 MVA.
83	Chhattisgarh	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
84	Chhattisgarh	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
85	Chhattisgarh	Lane Violation	500	Lane Violation violation under 119/177 MVA.
86	Goa	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
87	Goa	Triple Riding	1000	Triple Riding violation under 194C MVA.
88	Goa	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
89	Goa	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
90	Goa	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
91	Goa	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
92	Goa	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
93	Goa	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
94	Goa	Overspeeding	2000	Overspeeding violation under 183 MVA.
95	Goa	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
96	Goa	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
97	Goa	No PUCC	10000	No PUCC violation under 190(2) MVA.
98	Goa	Tinted Glass	500	Tinted Glass violation under 177 MVA.
99	Goa	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
100	Goa	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
101	Goa	Lane Violation	500	Lane Violation violation under 119/177 MVA.
102	Gujarat	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
103	Gujarat	Triple Riding	1000	Triple Riding violation under 194C MVA.
104	Gujarat	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
105	Gujarat	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
106	Gujarat	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
107	Gujarat	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
108	Gujarat	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
109	Gujarat	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
110	Gujarat	Overspeeding	2000	Overspeeding violation under 183 MVA.
111	Gujarat	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
112	Gujarat	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
113	Gujarat	No PUCC	10000	No PUCC violation under 190(2) MVA.
114	Gujarat	Tinted Glass	500	Tinted Glass violation under 177 MVA.
115	Gujarat	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
116	Gujarat	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
117	Gujarat	Lane Violation	500	Lane Violation violation under 119/177 MVA.
118	Haryana	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
119	Haryana	Triple Riding	1000	Triple Riding violation under 194C MVA.
120	Haryana	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
121	Haryana	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
122	Haryana	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
123	Haryana	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
124	Haryana	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
125	Haryana	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
126	Haryana	Overspeeding	2000	Overspeeding violation under 183 MVA.
127	Haryana	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
128	Haryana	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
129	Haryana	No PUCC	10000	No PUCC violation under 190(2) MVA.
130	Haryana	Tinted Glass	500	Tinted Glass violation under 177 MVA.
131	Haryana	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
132	Haryana	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
133	Haryana	Lane Violation	500	Lane Violation violation under 119/177 MVA.
134	Himachal Pradesh	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
135	Himachal Pradesh	Triple Riding	1000	Triple Riding violation under 194C MVA.
136	Himachal Pradesh	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
137	Himachal Pradesh	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
138	Himachal Pradesh	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
139	Himachal Pradesh	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
140	Himachal Pradesh	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
141	Himachal Pradesh	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
142	Himachal Pradesh	Overspeeding	2000	Overspeeding violation under 183 MVA.
143	Himachal Pradesh	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
144	Himachal Pradesh	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
145	Himachal Pradesh	No PUCC	10000	No PUCC violation under 190(2) MVA.
146	Himachal Pradesh	Tinted Glass	500	Tinted Glass violation under 177 MVA.
147	Himachal Pradesh	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
148	Himachal Pradesh	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
149	Himachal Pradesh	Lane Violation	500	Lane Violation violation under 119/177 MVA.
150	Jharkhand	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
151	Jharkhand	Triple Riding	1000	Triple Riding violation under 194C MVA.
152	Jharkhand	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
153	Jharkhand	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
154	Jharkhand	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
155	Jharkhand	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
156	Jharkhand	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
157	Jharkhand	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
158	Jharkhand	Overspeeding	2000	Overspeeding violation under 183 MVA.
159	Jharkhand	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
160	Jharkhand	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
161	Jharkhand	No PUCC	10000	No PUCC violation under 190(2) MVA.
162	Jharkhand	Tinted Glass	500	Tinted Glass violation under 177 MVA.
163	Jharkhand	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
164	Jharkhand	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
165	Jharkhand	Lane Violation	500	Lane Violation violation under 119/177 MVA.
166	Karnataka	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
167	Karnataka	Triple Riding	1000	Triple Riding violation under 194C MVA.
168	Karnataka	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
169	Karnataka	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
170	Karnataka	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
171	Karnataka	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
172	Karnataka	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
173	Karnataka	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
174	Karnataka	Overspeeding	2000	Overspeeding violation under 183 MVA.
175	Karnataka	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
176	Karnataka	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
177	Karnataka	No PUCC	10000	No PUCC violation under 190(2) MVA.
178	Karnataka	Tinted Glass	500	Tinted Glass violation under 177 MVA.
179	Karnataka	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
180	Karnataka	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
181	Karnataka	Lane Violation	500	Lane Violation violation under 119/177 MVA.
182	Kerala	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
183	Kerala	Triple Riding	1000	Triple Riding violation under 194C MVA.
184	Kerala	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
185	Kerala	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
186	Kerala	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
187	Kerala	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
188	Kerala	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
189	Kerala	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
190	Kerala	Overspeeding	2000	Overspeeding violation under 183 MVA.
191	Kerala	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
192	Kerala	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
193	Kerala	No PUCC	10000	No PUCC violation under 190(2) MVA.
194	Kerala	Tinted Glass	500	Tinted Glass violation under 177 MVA.
195	Kerala	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
196	Kerala	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
197	Kerala	Lane Violation	500	Lane Violation violation under 119/177 MVA.
198	Madhya Pradesh	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
199	Madhya Pradesh	Triple Riding	1000	Triple Riding violation under 194C MVA.
200	Madhya Pradesh	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
201	Madhya Pradesh	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
202	Madhya Pradesh	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
203	Madhya Pradesh	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
204	Madhya Pradesh	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
205	Madhya Pradesh	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
206	Madhya Pradesh	Overspeeding	2000	Overspeeding violation under 183 MVA.
207	Madhya Pradesh	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
208	Madhya Pradesh	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
209	Madhya Pradesh	No PUCC	10000	No PUCC violation under 190(2) MVA.
210	Madhya Pradesh	Tinted Glass	500	Tinted Glass violation under 177 MVA.
211	Madhya Pradesh	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
212	Madhya Pradesh	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
213	Madhya Pradesh	Lane Violation	500	Lane Violation violation under 119/177 MVA.
214	Maharashtra	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
215	Maharashtra	Triple Riding	1000	Triple Riding violation under 194C MVA.
216	Maharashtra	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
217	Maharashtra	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
218	Maharashtra	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
219	Maharashtra	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
220	Maharashtra	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
221	Maharashtra	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
222	Maharashtra	Overspeeding	2000	Overspeeding violation under 183 MVA.
223	Maharashtra	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
224	Maharashtra	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
225	Maharashtra	No PUCC	10000	No PUCC violation under 190(2) MVA.
226	Maharashtra	Tinted Glass	500	Tinted Glass violation under 177 MVA.
227	Maharashtra	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
228	Maharashtra	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
229	Maharashtra	Lane Violation	500	Lane Violation violation under 119/177 MVA.
230	Manipur	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
231	Manipur	Triple Riding	1000	Triple Riding violation under 194C MVA.
232	Manipur	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
233	Manipur	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
234	Manipur	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
235	Manipur	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
236	Manipur	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
237	Manipur	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
238	Manipur	Overspeeding	2000	Overspeeding violation under 183 MVA.
239	Manipur	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
240	Manipur	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
241	Manipur	No PUCC	10000	No PUCC violation under 190(2) MVA.
242	Manipur	Tinted Glass	500	Tinted Glass violation under 177 MVA.
243	Manipur	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
244	Manipur	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
245	Manipur	Lane Violation	500	Lane Violation violation under 119/177 MVA.
246	Meghalaya	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
247	Meghalaya	Triple Riding	1000	Triple Riding violation under 194C MVA.
248	Meghalaya	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
249	Meghalaya	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
250	Meghalaya	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
251	Meghalaya	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
252	Meghalaya	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
253	Meghalaya	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
254	Meghalaya	Overspeeding	2000	Overspeeding violation under 183 MVA.
255	Meghalaya	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
256	Meghalaya	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
257	Meghalaya	No PUCC	10000	No PUCC violation under 190(2) MVA.
258	Meghalaya	Tinted Glass	500	Tinted Glass violation under 177 MVA.
259	Meghalaya	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
260	Meghalaya	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
261	Meghalaya	Lane Violation	500	Lane Violation violation under 119/177 MVA.
262	Mizoram	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
263	Mizoram	Triple Riding	1000	Triple Riding violation under 194C MVA.
264	Mizoram	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
265	Mizoram	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
266	Mizoram	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
267	Mizoram	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
268	Mizoram	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
269	Mizoram	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
270	Mizoram	Overspeeding	2000	Overspeeding violation under 183 MVA.
271	Mizoram	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
272	Mizoram	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
273	Mizoram	No PUCC	10000	No PUCC violation under 190(2) MVA.
274	Mizoram	Tinted Glass	500	Tinted Glass violation under 177 MVA.
275	Mizoram	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
276	Mizoram	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
277	Mizoram	Lane Violation	500	Lane Violation violation under 119/177 MVA.
278	Nagaland	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
279	Nagaland	Triple Riding	1000	Triple Riding violation under 194C MVA.
280	Nagaland	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
281	Nagaland	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
282	Nagaland	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
283	Nagaland	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
284	Nagaland	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
285	Nagaland	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
286	Nagaland	Overspeeding	2000	Overspeeding violation under 183 MVA.
287	Nagaland	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
288	Nagaland	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
290	Nagaland	Tinted Glass	500	Tinted Glass violation under 177 MVA.
291	Nagaland	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
292	Nagaland	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
293	Nagaland	Lane Violation	500	Lane Violation violation under 119/177 MVA.
294	Odisha	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
295	Odisha	Triple Riding	1000	Triple Riding violation under 194C MVA.
296	Odisha	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
297	Odisha	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
298	Odisha	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
299	Odisha	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
300	Odisha	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
301	Odisha	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
302	Odisha	Overspeeding	2000	Overspeeding violation under 183 MVA.
303	Odisha	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
304	Odisha	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
305	Odisha	No PUCC	10000	No PUCC violation under 190(2) MVA.
306	Odisha	Tinted Glass	500	Tinted Glass violation under 177 MVA.
307	Odisha	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
308	Odisha	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
309	Odisha	Lane Violation	500	Lane Violation violation under 119/177 MVA.
310	Punjab	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
311	Punjab	Triple Riding	1000	Triple Riding violation under 194C MVA.
312	Punjab	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
313	Punjab	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
314	Punjab	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
315	Punjab	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
316	Punjab	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
317	Punjab	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
318	Punjab	Overspeeding	2000	Overspeeding violation under 183 MVA.
319	Punjab	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
320	Punjab	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
321	Punjab	No PUCC	10000	No PUCC violation under 190(2) MVA.
322	Punjab	Tinted Glass	500	Tinted Glass violation under 177 MVA.
323	Punjab	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
324	Punjab	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
325	Punjab	Lane Violation	500	Lane Violation violation under 119/177 MVA.
326	Rajasthan	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
327	Rajasthan	Triple Riding	1000	Triple Riding violation under 194C MVA.
328	Rajasthan	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
329	Rajasthan	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
330	Rajasthan	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
331	Rajasthan	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
332	Rajasthan	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
333	Rajasthan	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
334	Rajasthan	Overspeeding	2000	Overspeeding violation under 183 MVA.
335	Rajasthan	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
336	Rajasthan	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
337	Rajasthan	No PUCC	10000	No PUCC violation under 190(2) MVA.
338	Rajasthan	Tinted Glass	500	Tinted Glass violation under 177 MVA.
339	Rajasthan	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
340	Rajasthan	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
341	Rajasthan	Lane Violation	500	Lane Violation violation under 119/177 MVA.
342	Sikkim	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
343	Sikkim	Triple Riding	1000	Triple Riding violation under 194C MVA.
344	Sikkim	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
345	Sikkim	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
346	Sikkim	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
347	Sikkim	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
348	Sikkim	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
349	Sikkim	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
350	Sikkim	Overspeeding	2000	Overspeeding violation under 183 MVA.
351	Sikkim	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
352	Sikkim	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
353	Sikkim	No PUCC	10000	No PUCC violation under 190(2) MVA.
354	Sikkim	Tinted Glass	500	Tinted Glass violation under 177 MVA.
355	Sikkim	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
356	Sikkim	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
357	Sikkim	Lane Violation	500	Lane Violation violation under 119/177 MVA.
358	Tamil Nadu	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
359	Tamil Nadu	Triple Riding	1000	Triple Riding violation under 194C MVA.
360	Tamil Nadu	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
361	Tamil Nadu	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
433	Uttarakhand	No PUCC	10000	No PUCC violation under 190(2) MVA.
362	Tamil Nadu	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
363	Tamil Nadu	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
364	Tamil Nadu	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
365	Tamil Nadu	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
366	Tamil Nadu	Overspeeding	2000	Overspeeding violation under 183 MVA.
367	Tamil Nadu	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
368	Tamil Nadu	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
369	Tamil Nadu	No PUCC	10000	No PUCC violation under 190(2) MVA.
370	Tamil Nadu	Tinted Glass	500	Tinted Glass violation under 177 MVA.
371	Tamil Nadu	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
372	Tamil Nadu	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
373	Tamil Nadu	Lane Violation	500	Lane Violation violation under 119/177 MVA.
374	Telangana	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
375	Telangana	Triple Riding	1000	Triple Riding violation under 194C MVA.
376	Telangana	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
377	Telangana	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
378	Telangana	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
379	Telangana	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
380	Telangana	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
381	Telangana	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
382	Telangana	Overspeeding	2000	Overspeeding violation under 183 MVA.
383	Telangana	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
384	Telangana	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
385	Telangana	No PUCC	10000	No PUCC violation under 190(2) MVA.
386	Telangana	Tinted Glass	500	Tinted Glass violation under 177 MVA.
387	Telangana	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
388	Telangana	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
389	Telangana	Lane Violation	500	Lane Violation violation under 119/177 MVA.
390	Tripura	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
391	Tripura	Triple Riding	1000	Triple Riding violation under 194C MVA.
392	Tripura	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
393	Tripura	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
394	Tripura	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
395	Tripura	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
396	Tripura	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
397	Tripura	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
398	Tripura	Overspeeding	2000	Overspeeding violation under 183 MVA.
399	Tripura	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
400	Tripura	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
401	Tripura	No PUCC	10000	No PUCC violation under 190(2) MVA.
402	Tripura	Tinted Glass	500	Tinted Glass violation under 177 MVA.
403	Tripura	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
404	Tripura	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
405	Tripura	Lane Violation	500	Lane Violation violation under 119/177 MVA.
406	Uttar Pradesh	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
407	Uttar Pradesh	Triple Riding	1000	Triple Riding violation under 194C MVA.
408	Uttar Pradesh	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
409	Uttar Pradesh	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
410	Uttar Pradesh	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
411	Uttar Pradesh	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
412	Uttar Pradesh	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
413	Uttar Pradesh	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
414	Uttar Pradesh	Overspeeding	2000	Overspeeding violation under 183 MVA.
415	Uttar Pradesh	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
416	Uttar Pradesh	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
417	Uttar Pradesh	No PUCC	10000	No PUCC violation under 190(2) MVA.
418	Uttar Pradesh	Tinted Glass	500	Tinted Glass violation under 177 MVA.
419	Uttar Pradesh	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
420	Uttar Pradesh	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
421	Uttar Pradesh	Lane Violation	500	Lane Violation violation under 119/177 MVA.
422	Uttarakhand	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
423	Uttarakhand	Triple Riding	1000	Triple Riding violation under 194C MVA.
424	Uttarakhand	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
425	Uttarakhand	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
426	Uttarakhand	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
427	Uttarakhand	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
428	Uttarakhand	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
429	Uttarakhand	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
430	Uttarakhand	Overspeeding	2000	Overspeeding violation under 183 MVA.
431	Uttarakhand	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
432	Uttarakhand	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
434	Uttarakhand	Tinted Glass	500	Tinted Glass violation under 177 MVA.
435	Uttarakhand	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
436	Uttarakhand	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
437	Uttarakhand	Lane Violation	500	Lane Violation violation under 119/177 MVA.
438	West Bengal	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
439	West Bengal	Triple Riding	1000	Triple Riding violation under 194C MVA.
440	West Bengal	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
441	West Bengal	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
442	West Bengal	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
443	West Bengal	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
444	West Bengal	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
445	West Bengal	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
446	West Bengal	Overspeeding	2000	Overspeeding violation under 183 MVA.
447	West Bengal	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
448	West Bengal	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
449	West Bengal	No PUCC	10000	No PUCC violation under 190(2) MVA.
450	West Bengal	Tinted Glass	500	Tinted Glass violation under 177 MVA.
451	West Bengal	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
452	West Bengal	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
453	West Bengal	Lane Violation	500	Lane Violation violation under 119/177 MVA.
454	Delhi	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
455	Delhi	Triple Riding	1000	Triple Riding violation under 194C MVA.
456	Delhi	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
457	Delhi	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
458	Delhi	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
459	Delhi	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
460	Delhi	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
461	Delhi	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
462	Delhi	Overspeeding	2000	Overspeeding violation under 183 MVA.
463	Delhi	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
464	Delhi	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
465	Delhi	No PUCC	10000	No PUCC violation under 190(2) MVA.
466	Delhi	Tinted Glass	500	Tinted Glass violation under 177 MVA.
467	Delhi	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
468	Delhi	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
469	Delhi	Lane Violation	500	Lane Violation violation under 119/177 MVA.
470	Chandigarh	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
471	Chandigarh	Triple Riding	1000	Triple Riding violation under 194C MVA.
472	Chandigarh	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
473	Chandigarh	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
474	Chandigarh	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
475	Chandigarh	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
476	Chandigarh	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
477	Chandigarh	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
478	Chandigarh	Overspeeding	2000	Overspeeding violation under 183 MVA.
479	Chandigarh	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
480	Chandigarh	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
481	Chandigarh	No PUCC	10000	No PUCC violation under 190(2) MVA.
482	Chandigarh	Tinted Glass	500	Tinted Glass violation under 177 MVA.
483	Chandigarh	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
484	Chandigarh	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
485	Chandigarh	Lane Violation	500	Lane Violation violation under 119/177 MVA.
486	Jammu and Kashmir	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
487	Jammu and Kashmir	Triple Riding	1000	Triple Riding violation under 194C MVA.
488	Jammu and Kashmir	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
489	Jammu and Kashmir	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
490	Jammu and Kashmir	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
491	Jammu and Kashmir	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
492	Jammu and Kashmir	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
493	Jammu and Kashmir	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
494	Jammu and Kashmir	Overspeeding	2000	Overspeeding violation under 183 MVA.
495	Jammu and Kashmir	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
496	Jammu and Kashmir	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
497	Jammu and Kashmir	No PUCC	10000	No PUCC violation under 190(2) MVA.
498	Jammu and Kashmir	Tinted Glass	500	Tinted Glass violation under 177 MVA.
499	Jammu and Kashmir	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
500	Jammu and Kashmir	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
501	Jammu and Kashmir	Lane Violation	500	Lane Violation violation under 119/177 MVA.
502	Ladakh	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
503	Ladakh	Triple Riding	1000	Triple Riding violation under 194C MVA.
504	Ladakh	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
505	Ladakh	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
506	Ladakh	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
507	Ladakh	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
508	Ladakh	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
509	Ladakh	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
510	Ladakh	Overspeeding	2000	Overspeeding violation under 183 MVA.
511	Ladakh	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
512	Ladakh	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
513	Ladakh	No PUCC	10000	No PUCC violation under 190(2) MVA.
514	Ladakh	Tinted Glass	500	Tinted Glass violation under 177 MVA.
515	Ladakh	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
516	Ladakh	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
517	Ladakh	Lane Violation	500	Lane Violation violation under 119/177 MVA.
518	Puducherry	Driving without Helmet	1000	Driving without Helmet violation under 194D MVA.
519	Puducherry	Triple Riding	1000	Triple Riding violation under 194C MVA.
520	Puducherry	Seat Belt Violation	1000	Seat Belt Violation violation under 194B MVA.
521	Puducherry	Driving without Licence	5000	Driving without Licence violation under 3/181 MVA.
522	Puducherry	Driving without Insurance	2000	Driving without Insurance violation under 146/196 MVA.
523	Puducherry	Jumping Red Light	5000	Jumping Red Light violation under 184 MVA.
524	Puducherry	Dangerous Driving	10000	Dangerous Driving violation under 184 MVA.
525	Puducherry	Drunk Driving	10000	Drunk Driving violation under 185 MVA.
526	Puducherry	Overspeeding	2000	Overspeeding violation under 183 MVA.
527	Puducherry	Using Mobile Phone While Driving	5000	Using Mobile Phone While Driving violation under 184 MVA.
528	Puducherry	Wrong Side Driving	5000	Wrong Side Driving violation under 184 MVA.
529	Puducherry	No PUCC	10000	No PUCC violation under 190(2) MVA.
530	Puducherry	Tinted Glass	500	Tinted Glass violation under 177 MVA.
531	Puducherry	Pressure Horn Usage	5000	Pressure Horn Usage violation under 192 MVA.
532	Puducherry	Illegal Parking	500	Illegal Parking violation under 122/177 MVA.
533	Puducherry	Lane Violation	500	Lane Violation violation under 119/177 MVA.
\.


--
-- Data for Name: traffic_violations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.traffic_violations (id, state_name, offence_name, normalized_name, category, section, severity, first_offence_fine, repeat_offence_fine, description, keywords) FROM stdin;
1	Andhra Pradesh	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	High	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
2	Andhra Pradesh	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Critical	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
3	Andhra Pradesh	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
4	Andhra Pradesh	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
5	Andhra Pradesh	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
6	Andhra Pradesh	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
7	Andhra Pradesh	Dangerous Driving	dangerous_driving	Driving	184 MVA	Low	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
8	Andhra Pradesh	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
9	Andhra Pradesh	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
10	Andhra Pradesh	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
11	Andhra Pradesh	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
12	Andhra Pradesh	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
13	Andhra Pradesh	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
14	Andhra Pradesh	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
15	Andhra Pradesh	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
16	Andhra Pradesh	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
17	Arunachal Pradesh	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Medium	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
18	Arunachal Pradesh	Triple Riding	triple_riding	Two-Wheeler	194C MVA	High	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
19	Arunachal Pradesh	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
20	Arunachal Pradesh	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
21	Arunachal Pradesh	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
22	Arunachal Pradesh	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
23	Arunachal Pradesh	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
24	Arunachal Pradesh	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
25	Arunachal Pradesh	Overspeeding	overspeeding	Speeding	183 MVA	High	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
26	Arunachal Pradesh	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
27	Arunachal Pradesh	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	High	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
28	Arunachal Pradesh	No PUCC	no_pucc	Pollution	190(2) MVA	Medium	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
29	Arunachal Pradesh	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
30	Arunachal Pradesh	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	High	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
31	Arunachal Pradesh	Illegal Parking	illegal_parking	Parking	122/177 MVA	Low	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
32	Arunachal Pradesh	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
33	Assam	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Medium	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
34	Assam	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
35	Assam	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Critical	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
36	Assam	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
37	Assam	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Low	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
38	Assam	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
39	Assam	Dangerous Driving	dangerous_driving	Driving	184 MVA	Low	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
40	Assam	Drunk Driving	drunk_driving	Driving	185 MVA	High	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
41	Assam	Overspeeding	overspeeding	Speeding	183 MVA	High	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
42	Assam	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Critical	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
43	Assam	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Critical	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
44	Assam	No PUCC	no_pucc	Pollution	190(2) MVA	High	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
45	Assam	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Medium	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
46	Assam	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
47	Assam	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
48	Assam	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Critical	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
49	Bihar	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	High	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
50	Bihar	Triple Riding	triple_riding	Two-Wheeler	194C MVA	High	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
51	Bihar	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
52	Bihar	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
53	Bihar	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
54	Bihar	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Low	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
55	Bihar	Dangerous Driving	dangerous_driving	Driving	184 MVA	Critical	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
56	Bihar	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
57	Bihar	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
58	Bihar	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
59	Bihar	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Critical	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
60	Bihar	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
61	Bihar	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Medium	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
62	Bihar	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
63	Bihar	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
64	Bihar	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
65	Chhattisgarh	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
66	Chhattisgarh	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Low	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
67	Chhattisgarh	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	High	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
68	Chhattisgarh	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
69	Chhattisgarh	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
70	Chhattisgarh	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Medium	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
71	Chhattisgarh	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
72	Chhattisgarh	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
73	Chhattisgarh	Overspeeding	overspeeding	Speeding	183 MVA	Critical	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
74	Chhattisgarh	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
75	Chhattisgarh	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
76	Chhattisgarh	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
77	Chhattisgarh	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
78	Chhattisgarh	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	High	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
79	Chhattisgarh	Illegal Parking	illegal_parking	Parking	122/177 MVA	Critical	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
80	Chhattisgarh	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Medium	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
81	Goa	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	High	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
82	Goa	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Critical	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
83	Goa	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Critical	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
84	Goa	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
85	Goa	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
86	Goa	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
87	Goa	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
88	Goa	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
89	Goa	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
90	Goa	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
91	Goa	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
92	Goa	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
93	Goa	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
94	Goa	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
95	Goa	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
96	Goa	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Critical	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
97	Gujarat	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Critical	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
98	Gujarat	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Low	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
99	Gujarat	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
100	Gujarat	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
101	Gujarat	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
102	Gujarat	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
103	Gujarat	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
104	Gujarat	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
105	Gujarat	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
106	Gujarat	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
107	Gujarat	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	High	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
108	Gujarat	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
109	Gujarat	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Medium	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
110	Gujarat	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
111	Gujarat	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
112	Gujarat	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
113	Haryana	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Critical	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
114	Haryana	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
115	Haryana	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Low	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
116	Haryana	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
117	Haryana	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Low	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
118	Haryana	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
119	Haryana	Dangerous Driving	dangerous_driving	Driving	184 MVA	Critical	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
120	Haryana	Drunk Driving	drunk_driving	Driving	185 MVA	Critical	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
121	Haryana	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
122	Haryana	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Critical	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
123	Haryana	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Critical	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
124	Haryana	No PUCC	no_pucc	Pollution	190(2) MVA	Medium	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
125	Haryana	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
126	Haryana	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	High	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
127	Haryana	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
128	Haryana	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
129	Himachal Pradesh	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Critical	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
130	Himachal Pradesh	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
131	Himachal Pradesh	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
132	Himachal Pradesh	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
133	Himachal Pradesh	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
134	Himachal Pradesh	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Medium	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
135	Himachal Pradesh	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
136	Himachal Pradesh	Drunk Driving	drunk_driving	Driving	185 MVA	High	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
137	Himachal Pradesh	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
138	Himachal Pradesh	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Critical	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
139	Himachal Pradesh	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
140	Himachal Pradesh	No PUCC	no_pucc	Pollution	190(2) MVA	Medium	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
141	Himachal Pradesh	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
142	Himachal Pradesh	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
143	Himachal Pradesh	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
144	Himachal Pradesh	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
145	Jharkhand	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Medium	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
146	Jharkhand	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
147	Jharkhand	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
148	Jharkhand	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
149	Jharkhand	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
150	Jharkhand	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
151	Jharkhand	Dangerous Driving	dangerous_driving	Driving	184 MVA	Critical	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
152	Jharkhand	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
153	Jharkhand	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
154	Jharkhand	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
155	Jharkhand	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
156	Jharkhand	No PUCC	no_pucc	Pollution	190(2) MVA	Medium	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
157	Jharkhand	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
158	Jharkhand	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
159	Jharkhand	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
160	Jharkhand	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
161	Karnataka	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
162	Karnataka	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Low	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
163	Karnataka	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	High	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
164	Karnataka	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
165	Karnataka	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
166	Karnataka	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Low	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
167	Karnataka	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
168	Karnataka	Drunk Driving	drunk_driving	Driving	185 MVA	Critical	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
169	Karnataka	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
170	Karnataka	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	High	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
171	Karnataka	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
172	Karnataka	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
173	Karnataka	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Medium	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
174	Karnataka	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
175	Karnataka	Illegal Parking	illegal_parking	Parking	122/177 MVA	Low	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
176	Karnataka	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
177	Kerala	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
178	Kerala	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
179	Kerala	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Low	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
180	Kerala	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
181	Kerala	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
182	Kerala	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
183	Kerala	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
184	Kerala	Drunk Driving	drunk_driving	Driving	185 MVA	Critical	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
185	Kerala	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
186	Kerala	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
187	Kerala	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
188	Kerala	No PUCC	no_pucc	Pollution	190(2) MVA	Medium	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
189	Kerala	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Medium	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
190	Kerala	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
191	Kerala	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
269	Mizoram	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Critical	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
192	Kerala	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Critical	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
193	Madhya Pradesh	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
194	Madhya Pradesh	Triple Riding	triple_riding	Two-Wheeler	194C MVA	High	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
195	Madhya Pradesh	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Low	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
196	Madhya Pradesh	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
197	Madhya Pradesh	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
198	Madhya Pradesh	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Low	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
199	Madhya Pradesh	Dangerous Driving	dangerous_driving	Driving	184 MVA	Critical	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
200	Madhya Pradesh	Drunk Driving	drunk_driving	Driving	185 MVA	High	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
201	Madhya Pradesh	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
202	Madhya Pradesh	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
203	Madhya Pradesh	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
204	Madhya Pradesh	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
205	Madhya Pradesh	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
206	Madhya Pradesh	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
207	Madhya Pradesh	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
208	Madhya Pradesh	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
209	Maharashtra	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	High	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
210	Maharashtra	Triple Riding	triple_riding	Two-Wheeler	194C MVA	High	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
211	Maharashtra	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
212	Maharashtra	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
213	Maharashtra	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
214	Maharashtra	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Low	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
215	Maharashtra	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
216	Maharashtra	Drunk Driving	drunk_driving	Driving	185 MVA	High	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
217	Maharashtra	Overspeeding	overspeeding	Speeding	183 MVA	Critical	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
218	Maharashtra	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Critical	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
219	Maharashtra	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	High	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
220	Maharashtra	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
221	Maharashtra	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
222	Maharashtra	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Low	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
223	Maharashtra	Illegal Parking	illegal_parking	Parking	122/177 MVA	Critical	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
224	Maharashtra	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Critical	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
225	Manipur	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
226	Manipur	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
227	Manipur	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	High	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
228	Manipur	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Medium	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
229	Manipur	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
230	Manipur	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
231	Manipur	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
232	Manipur	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
233	Manipur	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
234	Manipur	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
235	Manipur	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Medium	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
236	Manipur	No PUCC	no_pucc	Pollution	190(2) MVA	Medium	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
237	Manipur	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
238	Manipur	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	High	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
239	Manipur	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
240	Manipur	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Medium	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
241	Meghalaya	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Critical	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
242	Meghalaya	Triple Riding	triple_riding	Two-Wheeler	194C MVA	High	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
243	Meghalaya	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	High	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
244	Meghalaya	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Medium	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
245	Meghalaya	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
246	Meghalaya	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
247	Meghalaya	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
248	Meghalaya	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
249	Meghalaya	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
250	Meghalaya	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
251	Meghalaya	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
252	Meghalaya	No PUCC	no_pucc	Pollution	190(2) MVA	High	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
253	Meghalaya	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
254	Meghalaya	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Low	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
255	Meghalaya	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
256	Meghalaya	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
257	Mizoram	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Critical	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
258	Mizoram	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Critical	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
259	Mizoram	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
260	Mizoram	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
261	Mizoram	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
262	Mizoram	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
263	Mizoram	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
264	Mizoram	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
265	Mizoram	Overspeeding	overspeeding	Speeding	183 MVA	High	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
266	Mizoram	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	High	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
267	Mizoram	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Medium	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
268	Mizoram	No PUCC	no_pucc	Pollution	190(2) MVA	High	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
270	Mizoram	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Low	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
271	Mizoram	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
272	Mizoram	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
273	Nagaland	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
274	Nagaland	Triple Riding	triple_riding	Two-Wheeler	194C MVA	High	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
275	Nagaland	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
276	Nagaland	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
277	Nagaland	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Low	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
278	Nagaland	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Medium	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
279	Nagaland	Dangerous Driving	dangerous_driving	Driving	184 MVA	Low	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
280	Nagaland	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
281	Nagaland	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
282	Nagaland	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Critical	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
283	Nagaland	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Medium	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
284	Nagaland	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
285	Nagaland	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
286	Nagaland	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
287	Nagaland	Illegal Parking	illegal_parking	Parking	122/177 MVA	Critical	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
288	Nagaland	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Medium	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
289	Odisha	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
290	Odisha	Triple Riding	triple_riding	Two-Wheeler	194C MVA	High	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
291	Odisha	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Critical	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
292	Odisha	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
293	Odisha	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
294	Odisha	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
295	Odisha	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
296	Odisha	Drunk Driving	drunk_driving	Driving	185 MVA	Medium	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
297	Odisha	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
298	Odisha	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Critical	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
299	Odisha	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
300	Odisha	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
301	Odisha	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Critical	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
302	Odisha	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
303	Odisha	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
304	Odisha	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Critical	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
305	Punjab	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	High	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
306	Punjab	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Low	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
307	Punjab	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Low	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
460	Delhi	No PUCC	no_pucc	Pollution	190(2) MVA	High	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
308	Punjab	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
309	Punjab	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
310	Punjab	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
311	Punjab	Dangerous Driving	dangerous_driving	Driving	184 MVA	Critical	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
312	Punjab	Drunk Driving	drunk_driving	Driving	185 MVA	High	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
313	Punjab	Overspeeding	overspeeding	Speeding	183 MVA	Critical	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
314	Punjab	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
315	Punjab	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
316	Punjab	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
317	Punjab	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
318	Punjab	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
319	Punjab	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
320	Punjab	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
321	Rajasthan	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Medium	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
322	Rajasthan	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Low	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
323	Rajasthan	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Low	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
324	Rajasthan	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Medium	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
325	Rajasthan	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
326	Rajasthan	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
327	Rajasthan	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
328	Rajasthan	Drunk Driving	drunk_driving	Driving	185 MVA	Critical	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
329	Rajasthan	Overspeeding	overspeeding	Speeding	183 MVA	Critical	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
330	Rajasthan	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
331	Rajasthan	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
332	Rajasthan	No PUCC	no_pucc	Pollution	190(2) MVA	High	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
333	Rajasthan	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
334	Rajasthan	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
335	Rajasthan	Illegal Parking	illegal_parking	Parking	122/177 MVA	Critical	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
336	Rajasthan	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Medium	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
337	Sikkim	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Medium	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
338	Sikkim	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Critical	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
339	Sikkim	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Critical	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
340	Sikkim	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
341	Sikkim	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
342	Sikkim	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
343	Sikkim	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
344	Sikkim	Drunk Driving	drunk_driving	Driving	185 MVA	High	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
345	Sikkim	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
461	Delhi	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Medium	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
346	Sikkim	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
347	Sikkim	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
348	Sikkim	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
349	Sikkim	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
350	Sikkim	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Low	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
351	Sikkim	Illegal Parking	illegal_parking	Parking	122/177 MVA	Low	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
352	Sikkim	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
353	Tamil Nadu	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Medium	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
354	Tamil Nadu	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Low	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
355	Tamil Nadu	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Critical	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
356	Tamil Nadu	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
357	Tamil Nadu	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
358	Tamil Nadu	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
359	Tamil Nadu	Dangerous Driving	dangerous_driving	Driving	184 MVA	Low	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
360	Tamil Nadu	Drunk Driving	drunk_driving	Driving	185 MVA	Medium	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
361	Tamil Nadu	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
362	Tamil Nadu	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
363	Tamil Nadu	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Critical	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
364	Tamil Nadu	No PUCC	no_pucc	Pollution	190(2) MVA	Medium	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
365	Tamil Nadu	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Critical	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
366	Tamil Nadu	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Low	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
367	Tamil Nadu	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
368	Tamil Nadu	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Medium	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
369	Telangana	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Critical	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
370	Telangana	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Critical	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
371	Telangana	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
372	Telangana	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
373	Telangana	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Low	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
374	Telangana	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Low	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
375	Telangana	Dangerous Driving	dangerous_driving	Driving	184 MVA	Low	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
376	Telangana	Drunk Driving	drunk_driving	Driving	185 MVA	Critical	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
377	Telangana	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
378	Telangana	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
379	Telangana	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Critical	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
380	Telangana	No PUCC	no_pucc	Pollution	190(2) MVA	High	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
381	Telangana	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
382	Telangana	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
383	Telangana	Illegal Parking	illegal_parking	Parking	122/177 MVA	Critical	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
384	Telangana	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
385	Tripura	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Medium	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
386	Tripura	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
387	Tripura	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	High	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
388	Tripura	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Medium	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
389	Tripura	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
390	Tripura	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Low	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
391	Tripura	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
392	Tripura	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
393	Tripura	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
394	Tripura	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
395	Tripura	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	High	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
396	Tripura	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
397	Tripura	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Medium	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
398	Tripura	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	High	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
399	Tripura	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
400	Tripura	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Medium	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
401	Uttar Pradesh	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
402	Uttar Pradesh	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Critical	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
403	Uttar Pradesh	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
404	Uttar Pradesh	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
405	Uttar Pradesh	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Critical	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
406	Uttar Pradesh	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Low	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
407	Uttar Pradesh	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
408	Uttar Pradesh	Drunk Driving	drunk_driving	Driving	185 MVA	High	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
409	Uttar Pradesh	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
410	Uttar Pradesh	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
411	Uttar Pradesh	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	High	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
412	Uttar Pradesh	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
413	Uttar Pradesh	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
414	Uttar Pradesh	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
415	Uttar Pradesh	Illegal Parking	illegal_parking	Parking	122/177 MVA	Low	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
416	Uttar Pradesh	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Critical	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
417	Uttarakhand	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Critical	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
418	Uttarakhand	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Critical	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
419	Uttarakhand	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
420	Uttarakhand	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
421	Uttarakhand	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
422	Uttarakhand	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
423	Uttarakhand	Dangerous Driving	dangerous_driving	Driving	184 MVA	Low	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
424	Uttarakhand	Drunk Driving	drunk_driving	Driving	185 MVA	Medium	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
425	Uttarakhand	Overspeeding	overspeeding	Speeding	183 MVA	Critical	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
426	Uttarakhand	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	High	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
427	Uttarakhand	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Critical	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
428	Uttarakhand	No PUCC	no_pucc	Pollution	190(2) MVA	High	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
429	Uttarakhand	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	High	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
430	Uttarakhand	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
431	Uttarakhand	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
432	Uttarakhand	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
433	West Bengal	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
434	West Bengal	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Low	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
435	West Bengal	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
436	West Bengal	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Medium	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
437	West Bengal	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
438	West Bengal	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
439	West Bengal	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
440	West Bengal	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
441	West Bengal	Overspeeding	overspeeding	Speeding	183 MVA	Low	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
442	West Bengal	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
443	West Bengal	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Critical	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
444	West Bengal	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
445	West Bengal	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
446	West Bengal	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Critical	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
447	West Bengal	Illegal Parking	illegal_parking	Parking	122/177 MVA	High	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
448	West Bengal	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Medium	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
449	Delhi	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	High	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
450	Delhi	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Low	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
451	Delhi	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Medium	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
452	Delhi	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
453	Delhi	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
454	Delhi	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Critical	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
455	Delhi	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
456	Delhi	Drunk Driving	drunk_driving	Driving	185 MVA	Medium	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
457	Delhi	Overspeeding	overspeeding	Speeding	183 MVA	Critical	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
458	Delhi	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Critical	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
459	Delhi	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
462	Delhi	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
463	Delhi	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
464	Delhi	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
465	Chandigarh	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
466	Chandigarh	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Critical	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
467	Chandigarh	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Low	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
468	Chandigarh	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
469	Chandigarh	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Low	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
470	Chandigarh	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	Low	5000	10000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
471	Chandigarh	Dangerous Driving	dangerous_driving	Driving	184 MVA	High	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
472	Chandigarh	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
473	Chandigarh	Overspeeding	overspeeding	Speeding	183 MVA	Critical	2000	4000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
474	Chandigarh	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Critical	5000	5000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
475	Chandigarh	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Low	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
476	Chandigarh	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
477	Chandigarh	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Critical	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
478	Chandigarh	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
479	Chandigarh	Illegal Parking	illegal_parking	Parking	122/177 MVA	Critical	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
480	Chandigarh	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
481	Jammu and Kashmir	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Medium	1000	1000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
482	Jammu and Kashmir	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
483	Jammu and Kashmir	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	High	1000	2000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
484	Jammu and Kashmir	Driving without Licence	driving_without_licence	Documents	3/181 MVA	High	5000	5000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
485	Jammu and Kashmir	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	High	2000	2000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
486	Jammu and Kashmir	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
487	Jammu and Kashmir	Dangerous Driving	dangerous_driving	Driving	184 MVA	Critical	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
488	Jammu and Kashmir	Drunk Driving	drunk_driving	Driving	185 MVA	Medium	10000	20000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
489	Jammu and Kashmir	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
490	Jammu and Kashmir	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
491	Jammu and Kashmir	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Medium	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
492	Jammu and Kashmir	No PUCC	no_pucc	Pollution	190(2) MVA	Critical	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
493	Jammu and Kashmir	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Critical	500	1000	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
494	Jammu and Kashmir	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	Medium	5000	10000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
495	Jammu and Kashmir	Illegal Parking	illegal_parking	Parking	122/177 MVA	Medium	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
496	Jammu and Kashmir	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	Low	500	500	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
497	Ladakh	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	Low	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
498	Ladakh	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	1000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
499	Ladakh	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	Critical	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
500	Ladakh	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Critical	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
501	Ladakh	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
502	Ladakh	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
503	Ladakh	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	20000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
504	Ladakh	Drunk Driving	drunk_driving	Driving	185 MVA	Low	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
505	Ladakh	Overspeeding	overspeeding	Speeding	183 MVA	Medium	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
506	Ladakh	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Low	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
507	Ladakh	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Critical	5000	10000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
508	Ladakh	No PUCC	no_pucc	Pollution	190(2) MVA	Low	10000	20000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
509	Ladakh	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
510	Ladakh	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	High	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
511	Ladakh	Illegal Parking	illegal_parking	Parking	122/177 MVA	Low	500	1000	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
512	Ladakh	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
513	Puducherry	Driving without Helmet	driving_without_helmet	Helmet	194D MVA	High	1000	2000	Driving without Helmet violation under 194D MVA.	driving without helmet, traffic challan, road safety
514	Puducherry	Triple Riding	triple_riding	Two-Wheeler	194C MVA	Medium	1000	2000	Triple Riding violation under 194C MVA.	triple riding, traffic challan, road safety
515	Puducherry	Seat Belt Violation	seat_belt_violation	Seat Belt	194B MVA	High	1000	1000	Seat Belt Violation violation under 194B MVA.	seat belt violation, traffic challan, road safety
516	Puducherry	Driving without Licence	driving_without_licence	Documents	3/181 MVA	Low	5000	10000	Driving without Licence violation under 3/181 MVA.	driving without licence, traffic challan, road safety
517	Puducherry	Driving without Insurance	driving_without_insurance	Documents	146/196 MVA	Medium	2000	4000	Driving without Insurance violation under 146/196 MVA.	driving without insurance, traffic challan, road safety
518	Puducherry	Jumping Red Light	jumping_red_light	Traffic Signal	184 MVA	High	5000	5000	Jumping Red Light violation under 184 MVA.	jumping red light, traffic challan, road safety
519	Puducherry	Dangerous Driving	dangerous_driving	Driving	184 MVA	Medium	10000	10000	Dangerous Driving violation under 184 MVA.	dangerous driving, traffic challan, road safety
520	Puducherry	Drunk Driving	drunk_driving	Driving	185 MVA	High	10000	10000	Drunk Driving violation under 185 MVA.	drunk driving, traffic challan, road safety
521	Puducherry	Overspeeding	overspeeding	Speeding	183 MVA	Critical	2000	2000	Overspeeding violation under 183 MVA.	overspeeding, traffic challan, road safety
522	Puducherry	Using Mobile Phone While Driving	using_mobile_phone_while_driving	Driving	184 MVA	Medium	5000	10000	Using Mobile Phone While Driving violation under 184 MVA.	using mobile phone while driving, traffic challan, road safety
523	Puducherry	Wrong Side Driving	wrong_side_driving	Driving	184 MVA	Medium	5000	5000	Wrong Side Driving violation under 184 MVA.	wrong side driving, traffic challan, road safety
524	Puducherry	No PUCC	no_pucc	Pollution	190(2) MVA	High	10000	10000	No PUCC violation under 190(2) MVA.	no pucc, traffic challan, road safety
525	Puducherry	Tinted Glass	tinted_glass	Vehicle Modification	177 MVA	Low	500	500	Tinted Glass violation under 177 MVA.	tinted glass, traffic challan, road safety
526	Puducherry	Pressure Horn Usage	pressure_horn_usage	Noise Pollution	192 MVA	High	5000	5000	Pressure Horn Usage violation under 192 MVA.	pressure horn usage, traffic challan, road safety
527	Puducherry	Illegal Parking	illegal_parking	Parking	122/177 MVA	Critical	500	500	Illegal Parking violation under 122/177 MVA.	illegal parking, traffic challan, road safety
528	Puducherry	Lane Violation	lane_violation	Lane Discipline	119/177 MVA	High	500	1000	Lane Violation violation under 119/177 MVA.	lane violation, traffic challan, road safety
\.


--
-- Name: Rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rule_id_seq"', 1, false);


--
-- Name: State_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."State_id_seq"', 1, false);


--
-- Name: traffic_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.traffic_questions_id_seq', 192, true);


--
-- Name: traffic_quiz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.traffic_quiz_id_seq', 1, false);


--
-- Name: traffic_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.traffic_rules_id_seq', 533, true);


--
-- Name: traffic_violations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.traffic_violations_id_seq', 528, true);


--
-- Name: Rule Rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rule"
    ADD CONSTRAINT "Rule_pkey" PRIMARY KEY (id);


--
-- Name: State State_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."State"
    ADD CONSTRAINT "State_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: traffic_questions traffic_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_questions
    ADD CONSTRAINT traffic_questions_pkey PRIMARY KEY (id);


--
-- Name: traffic_questions traffic_questions_question_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_questions
    ADD CONSTRAINT traffic_questions_question_key UNIQUE (question);


--
-- Name: traffic_quiz traffic_quiz_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_quiz
    ADD CONSTRAINT traffic_quiz_pkey PRIMARY KEY (id);


--
-- Name: traffic_rules traffic_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_rules
    ADD CONSTRAINT traffic_rules_pkey PRIMARY KEY (id);


--
-- Name: traffic_violations traffic_violations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_violations
    ADD CONSTRAINT traffic_violations_pkey PRIMARY KEY (id);


--
-- Name: Rule Rule_stateId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rule"
    ADD CONSTRAINT "Rule_stateId_fkey" FOREIGN KEY ("stateId") REFERENCES public."State"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict qSa2WxlJqRCjMha0lXgFIWg0kriitZ1vTmyJaVupgGzmvZ0wq30l6Z7bbpmy0vt

