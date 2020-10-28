--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0
-- Dumped by pg_dump version 13.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: articles; Type: TABLE DATA; Schema: newscollectorinfo; Owner: postgres
--

COPY newscollectorinfo.articles (id, created_at, title, web_content_url, api_content_url, article_type, publication_date, author, media_outlet_id, content_id) FROM stdin;
2	2020-10-28 03:57:27.932663+00	Sudoku 4180 medium	https://www.theguardian.com/lifeandstyle/2018/oct/02/sudoku-4180-medium	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
3	2020-10-28 03:57:27.932663+00	Physical restraint used on 50% more NHS patients with learning disabilities	https://www.theguardian.com/society/2018/oct/02/physical-restraint-used-on-50-more-nhs-patients-with-learning-disabilities	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
4	2020-10-28 03:57:27.932663+00	Google launches DIY smart Nest Thermostat E	https://www.theguardian.com/technology/2018/oct/02/google-launches-new-nest-e-smart-thermostat-install-yourself	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
5	2020-10-28 03:57:27.932663+00	Bruce Grobbelaar: ‘How many people did I kill? I couldn’t tell you’ | Donald McRae	https://www.theguardian.com/football/2018/oct/01/bruce-grobbelaar-interview-donald-mcrae	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
6	2020-10-28 03:57:27.932663+00	Emergency funding for social care to be announced at Tory conference	https://www.theguardian.com/society/2018/oct/02/emergency-funding-for-social-care-to-be-announced-at-tory-conference	\N	Opinion	2018-10-01 23:01:08	\N	1	\N
7	2020-10-28 03:57:27.932663+00	Sajid Javid pledges to get tough on middle-class cocaine users	https://www.theguardian.com/politics/2018/oct/02/sajid-javid-pledges-to-get-tough-on-middle-class-cocaine-users	\N	Opinion	2018-10-01 23:01:08	\N	1	\N
8	2020-10-28 03:57:27.932663+00	Cryptic crossword No 27,629	https://www.theguardian.com/crosswords/cryptic/27629	\N	Opinion	2018-10-01 23:00:08	\N	1	\N
9	2020-10-28 03:57:27.932663+00	Quick crossword No 15,102	https://www.theguardian.com/crosswords/quick/15102	\N	Opinion	2018-10-01 23:00:08	\N	1	\N
10	2020-10-28 03:57:27.932663+00	Half of women 'will develop dementia or Parkinson's or have a stroke'	https://www.theguardian.com/society/2018/oct/01/half-of-women-will-develop-dementia-or-parkinsons-or-have-a-stroke	\N	Opinion	2018-10-01 22:30:08	\N	1	\N
11	2020-10-28 03:57:27.932663+00	Cristiano Ronaldo accuser spells out rape claims in magazine	https://www.theguardian.com/football/2018/oct/01/cristiano-ronaldo-accuser-spells-out-claims-in-magazine	\N	Opinion	2018-10-01 22:17:07	\N	1	\N
12	2020-10-28 04:07:22.262479+00	Bruce Grobbelaar: ‘How many people did I kill? I couldn’t tell you’ | Donald McRae	https://www.theguardian.com/football/2018/oct/01/bruce-grobbelaar-interview-donald-mcrae	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
13	2020-10-28 04:07:22.262479+00	Physical restraint used on 50% more NHS patients with learning disabilities	https://www.theguardian.com/society/2018/oct/02/physical-restraint-used-on-50-more-nhs-patients-with-learning-disabilities	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
14	2020-10-28 04:07:22.262479+00	Google launches DIY smart Nest Thermostat E	https://www.theguardian.com/technology/2018/oct/02/google-launches-new-nest-e-smart-thermostat-install-yourself	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
15	2020-10-28 04:07:22.262479+00	Sudoku 4180 medium	https://www.theguardian.com/lifeandstyle/2018/oct/02/sudoku-4180-medium	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
16	2020-10-28 04:07:22.262479+00	Sajid Javid pledges to get tough on middle-class cocaine users	https://www.theguardian.com/politics/2018/oct/02/sajid-javid-pledges-to-get-tough-on-middle-class-cocaine-users	\N	Opinion	2018-10-01 23:01:08	\N	1	\N
17	2020-10-28 04:07:22.262479+00	Emergency funding for social care to be announced at Tory conference	https://www.theguardian.com/society/2018/oct/02/emergency-funding-for-social-care-to-be-announced-at-tory-conference	\N	Opinion	2018-10-01 23:01:08	\N	1	\N
18	2020-10-28 04:07:22.262479+00	Quick crossword No 15,102	https://www.theguardian.com/crosswords/quick/15102	\N	Opinion	2018-10-01 23:00:08	\N	1	\N
19	2020-10-28 04:07:22.262479+00	Cryptic crossword No 27,629	https://www.theguardian.com/crosswords/cryptic/27629	\N	Opinion	2018-10-01 23:00:08	\N	1	\N
20	2020-10-28 04:07:22.262479+00	Half of women 'will develop dementia or Parkinson's or have a stroke'	https://www.theguardian.com/society/2018/oct/01/half-of-women-will-develop-dementia-or-parkinsons-or-have-a-stroke	\N	Opinion	2018-10-01 22:30:08	\N	1	\N
21	2020-10-28 04:07:22.262479+00	Cristiano Ronaldo accuser spells out rape claims in magazine	https://www.theguardian.com/football/2018/oct/01/cristiano-ronaldo-accuser-spells-out-claims-in-magazine	\N	Opinion	2018-10-01 22:17:07	\N	1	\N
22	2020-10-28 04:16:22.954982+00	Bruce Grobbelaar: ‘How many people did I kill? I couldn’t tell you’ | Donald McRae	https://www.theguardian.com/football/2018/oct/01/bruce-grobbelaar-interview-donald-mcrae	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
23	2020-10-28 04:16:22.954982+00	Sudoku 4180 medium	https://www.theguardian.com/lifeandstyle/2018/oct/02/sudoku-4180-medium	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
24	2020-10-28 04:16:22.954982+00	Physical restraint used on 50% more NHS patients with learning disabilities	https://www.theguardian.com/society/2018/oct/02/physical-restraint-used-on-50-more-nhs-patients-with-learning-disabilities	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
25	2020-10-28 04:16:22.954982+00	Google launches DIY smart Nest Thermostat E	https://www.theguardian.com/technology/2018/oct/02/google-launches-new-nest-e-smart-thermostat-install-yourself	\N	Opinion	2018-10-01 23:01:09	\N	1	\N
26	2020-10-28 04:16:22.954982+00	Sajid Javid pledges to get tough on middle-class cocaine users	https://www.theguardian.com/politics/2018/oct/02/sajid-javid-pledges-to-get-tough-on-middle-class-cocaine-users	\N	Opinion	2018-10-01 23:01:08	\N	1	\N
27	2020-10-28 04:16:22.954982+00	Emergency funding for social care to be announced at Tory conference	https://www.theguardian.com/society/2018/oct/02/emergency-funding-for-social-care-to-be-announced-at-tory-conference	\N	Opinion	2018-10-01 23:01:08	\N	1	\N
28	2020-10-28 04:16:22.954982+00	Cryptic crossword No 27,629	https://www.theguardian.com/crosswords/cryptic/27629	\N	Opinion	2018-10-01 23:00:08	\N	1	\N
29	2020-10-28 04:16:22.954982+00	Quick crossword No 15,102	https://www.theguardian.com/crosswords/quick/15102	\N	Opinion	2018-10-01 23:00:08	\N	1	\N
30	2020-10-28 04:16:22.954982+00	Half of women 'will develop dementia or Parkinson's or have a stroke'	https://www.theguardian.com/society/2018/oct/01/half-of-women-will-develop-dementia-or-parkinsons-or-have-a-stroke	\N	Opinion	2018-10-01 22:30:08	\N	1	\N
31	2020-10-28 04:16:22.954982+00	Cristiano Ronaldo accuser spells out rape claims in magazine	https://www.theguardian.com/football/2018/oct/01/cristiano-ronaldo-accuser-spells-out-claims-in-magazine	\N	Opinion	2018-10-01 22:17:07	\N	1	\N
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: newscollectorinfo; Owner: postgres
--

SELECT pg_catalog.setval('newscollectorinfo.articles_id_seq', 31, true);


--
-- PostgreSQL database dump complete
--

