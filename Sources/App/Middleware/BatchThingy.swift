//
//  File.swift
//  
//
//  Created by Wadÿe on 02/06/2023.
//

import Foundation
import TabularData

func getBatchUsers() -> [User.CSVCreateContext] {
    let json = """
    [
      {
        "firstName": "Rube",
        "lastName": "Parsell",
        "email": "rparsell0@umich.edu",
        "password": "YknVK6b1E"
      },
      {
        "firstName": "Cris",
        "lastName": "Newburn",
        "email": "cnewburn1@uol.com.br",
        "password": "zfaRsXzY"
      },
      {
        "firstName": "Hadlee",
        "lastName": "Paolicchi",
        "email": "hpaolicchi2@tripadvisor.com",
        "password": "GMeiL2Imj6"
      },
      {
        "firstName": "Dulci",
        "lastName": "Kaesmakers",
        "email": "dkaesmakers3@surveymonkey.com",
        "password": "fpnGJpkq"
      },
      {
        "firstName": "Ailbert",
        "lastName": "Pyrton",
        "email": "apyrton4@ox.ac.uk",
        "password": "0cHndzOI"
      },
      {
        "firstName": "Levin",
        "lastName": "Bodycombe",
        "email": "lbodycombe5@spiegel.de",
        "password": "KZLTmFr5z"
      },
      {
        "firstName": "Pippa",
        "lastName": "Toolan",
        "email": "ptoolan6@dot.gov",
        "password": "lzjaa2Sha7y"
      },
      {
        "firstName": "Heinrick",
        "lastName": "Joslyn",
        "email": "hjoslyn7@quantcast.com",
        "password": "wA4B6SbNnqW"
      },
      {
        "firstName": "Halimeda",
        "lastName": "Jones",
        "email": "hjones8@japanpost.jp",
        "password": "nsQFuY6C9P6"
      },
      {
        "firstName": "Harmonia",
        "lastName": "Cawdell",
        "email": "hcawdell9@narod.ru",
        "password": "kkRyNrnb"
      },
      {
        "firstName": "Husein",
        "lastName": "Brandom",
        "email": "hbrandoma@blogs.com",
        "password": "Er4zNNZY3jfS"
      },
      {
        "firstName": "Kristoffer",
        "lastName": "Cicetti",
        "email": "kcicettib@clickbank.net",
        "password": "1nVY66AxNg"
      },
      {
        "firstName": "Hadlee",
        "lastName": "Bloor",
        "email": "hbloorc@oracle.com",
        "password": "gGORcvh91QDN"
      },
      {
        "firstName": "Winston",
        "lastName": "Swinney",
        "email": "wswinneyd@bloglines.com",
        "password": "Z0uqZtc2GZN4"
      },
      {
        "firstName": "Madelin",
        "lastName": "Hedau",
        "email": "mhedaue@mtv.com",
        "password": "tx4TtZu"
      },
      {
        "firstName": "Mellisa",
        "lastName": "Bevis",
        "email": "mbevisf@economist.com",
        "password": "NY8ntjBV"
      },
      {
        "firstName": "Stefania",
        "lastName": "Heikkinen",
        "email": "sheikkineng@infoseek.co.jp",
        "password": "sBQLMB2Eth"
      },
      {
        "firstName": "Bastien",
        "lastName": "Tomowicz",
        "email": "btomowiczh@skype.com",
        "password": "sENzVIY90w"
      },
      {
        "firstName": "Joseito",
        "lastName": "Pippard",
        "email": "jpippardi@hao123.com",
        "password": "A3Mq6BkV4x"
      },
      {
        "firstName": "Carey",
        "lastName": "Dobbie",
        "email": "cdobbiej@msu.edu",
        "password": "z8pFWj1"
      },
      {
        "firstName": "Kevina",
        "lastName": "Firpo",
        "email": "kfirpok@ask.com",
        "password": "So823481DEv0"
      },
      {
        "firstName": "Clarinda",
        "lastName": "Brewin",
        "email": "cbrewinl@ucoz.com",
        "password": "zMryU9WG1UuA"
      },
      {
        "firstName": "Glenden",
        "lastName": "Barends",
        "email": "gbarendsm@redcross.org",
        "password": "A01fMinEI"
      },
      {
        "firstName": "Burg",
        "lastName": "Cochet",
        "email": "bcochetn@marketwatch.com",
        "password": "bEAvLlFn"
      },
      {
        "firstName": "Casey",
        "lastName": "Lemm",
        "email": "clemmo@foxnews.com",
        "password": "B2VvYDwE"
      },
      {
        "firstName": "Reynard",
        "lastName": "Bowdler",
        "email": "rbowdlerp@senate.gov",
        "password": "9twR59"
      },
      {
        "firstName": "Kacey",
        "lastName": "Farr",
        "email": "kfarrq@google.nl",
        "password": "YmcFvCV5jL"
      },
      {
        "firstName": "Ariel",
        "lastName": "Densun",
        "email": "adensunr@latimes.com",
        "password": "LnMWgZm"
      },
      {
        "firstName": "Kary",
        "lastName": "O'Cahsedy",
        "email": "kocahsedys@mapy.cz",
        "password": "8VUlA4"
      },
      {
        "firstName": "Omar",
        "lastName": "Rance",
        "email": "orancet@tinyurl.com",
        "password": "eNWrZTL1aAFj"
      },
      {
        "firstName": "Hilde",
        "lastName": "Grabb",
        "email": "hgrabbu@hc360.com",
        "password": "WWYjjdqoJKV"
      },
      {
        "firstName": "Prentice",
        "lastName": "Bart",
        "email": "pbartv@mozilla.com",
        "password": "mnC0j1X"
      },
      {
        "firstName": "Ashlin",
        "lastName": "Hradsky",
        "email": "ahradskyw@ow.ly",
        "password": "ecqfhkJQGq"
      },
      {
        "firstName": "Afton",
        "lastName": "Heiden",
        "email": "aheidenx@statcounter.com",
        "password": "OP5TbOLtDM"
      },
      {
        "firstName": "Cord",
        "lastName": "Bucklee",
        "email": "cbuckleey@parallels.com",
        "password": "5jixTw"
      },
      {
        "firstName": "Courtnay",
        "lastName": "Moneypenny",
        "email": "cmoneypennyz@amazon.com",
        "password": "Bxswg0"
      },
      {
        "firstName": "Mommy",
        "lastName": "Secret",
        "email": "msecret10@geocities.com",
        "password": "GPhs86InAd"
      },
      {
        "firstName": "Adria",
        "lastName": "Errington",
        "email": "aerrington11@networksolutions.com",
        "password": "4UKPZ3F7"
      },
      {
        "firstName": "Francisca",
        "lastName": "Dupre",
        "email": "fdupre12@businesswire.com",
        "password": "p69lXMECQq36"
      },
      {
        "firstName": "Jolee",
        "lastName": "Schimek",
        "email": "jschimek13@google.cn",
        "password": "Y9fYiR7oHk"
      },
      {
        "firstName": "Adelaide",
        "lastName": "Beedie",
        "email": "abeedie14@guardian.co.uk",
        "password": "mdEWrY"
      },
      {
        "firstName": "Sam",
        "lastName": "Bernot",
        "email": "sbernot15@go.com",
        "password": "bdLEmvP8W2"
      },
      {
        "firstName": "Sebastian",
        "lastName": "Granger",
        "email": "sgranger16@bandcamp.com",
        "password": "tZbJNM1KB8Mf"
      },
      {
        "firstName": "Thorvald",
        "lastName": "Riddall",
        "email": "triddall17@discuz.net",
        "password": "s0o74YHScj"
      },
      {
        "firstName": "Karena",
        "lastName": "O'Giany",
        "email": "kogiany18@booking.com",
        "password": "1pfvVpRGwOIS"
      },
      {
        "firstName": "Petey",
        "lastName": "Stit",
        "email": "pstit19@amazonaws.com",
        "password": "xBTXdo"
      },
      {
        "firstName": "Ailina",
        "lastName": "Borrett",
        "email": "aborrett1a@huffingtonpost.com",
        "password": "k2HRTUjUN"
      },
      {
        "firstName": "Tallie",
        "lastName": "Whettleton",
        "email": "twhettleton1b@wsj.com",
        "password": "qmHhqByH0rRt"
      },
      {
        "firstName": "Idette",
        "lastName": "Ormshaw",
        "email": "iormshaw1c@dailymotion.com",
        "password": "LlvP1pKfpjhu"
      },
      {
        "firstName": "Rinaldo",
        "lastName": "Jewitt",
        "email": "rjewitt1d@mail.ru",
        "password": "3VRiUK9CE"
      },
      {
        "firstName": "Keene",
        "lastName": "Turbill",
        "email": "kturbill1e@walmart.com",
        "password": "hAApQPs6F39"
      },
      {
        "firstName": "Jae",
        "lastName": "MacAlinden",
        "email": "jmacalinden1f@wikia.com",
        "password": "gtUJtH"
      },
      {
        "firstName": "Merna",
        "lastName": "Piggins",
        "email": "mpiggins1g@about.me",
        "password": "3Z4lWX"
      },
      {
        "firstName": "Jessee",
        "lastName": "Behnecke",
        "email": "jbehnecke1h@163.com",
        "password": "UO9Uew6vz7L"
      },
      {
        "firstName": "Duncan",
        "lastName": "Hender",
        "email": "dhender1i@umich.edu",
        "password": "GoXeF7B"
      },
      {
        "firstName": "Will",
        "lastName": "Florentine",
        "email": "wflorentine1j@theguardian.com",
        "password": "YIwOZPgv98In"
      },
      {
        "firstName": "Ivonne",
        "lastName": "Van der Daal",
        "email": "ivanderdaal1k@xing.com",
        "password": "VKm2tkQ1"
      },
      {
        "firstName": "Garner",
        "lastName": "O'Mohun",
        "email": "gomohun1l@blinklist.com",
        "password": "v3C6Pq"
      },
      {
        "firstName": "Christal",
        "lastName": "Borlease",
        "email": "cborlease1m@istockphoto.com",
        "password": "YRXBIZWq7"
      },
      {
        "firstName": "Therine",
        "lastName": "Lashley",
        "email": "tlashley1n@taobao.com",
        "password": "H2QApF"
      },
      {
        "firstName": "Leonardo",
        "lastName": "Banke",
        "email": "lbanke1o@xing.com",
        "password": "6hPnhtv4ktG8"
      },
      {
        "firstName": "Russell",
        "lastName": "Nursey",
        "email": "rnursey1p@wp.com",
        "password": "N3FesWj"
      },
      {
        "firstName": "Jodie",
        "lastName": "Boerderman",
        "email": "jboerderman1q@wordpress.org",
        "password": "8TjeWmr9zTTx"
      },
      {
        "firstName": "Annette",
        "lastName": "Gebuhr",
        "email": "agebuhr1r@mapy.cz",
        "password": "7LEJbbsfiS7"
      },
      {
        "firstName": "Cassie",
        "lastName": "Guiden",
        "email": "cguiden1s@alibaba.com",
        "password": "AjtTYGXa1TO"
      },
      {
        "firstName": "Kay",
        "lastName": "Jesson",
        "email": "kjesson1t@sun.com",
        "password": "UGoAVnp"
      },
      {
        "firstName": "Pepe",
        "lastName": "Baldacchi",
        "email": "pbaldacchi1u@163.com",
        "password": "CwQJOLMpRQ6"
      },
      {
        "firstName": "Flo",
        "lastName": "Hammarberg",
        "email": "fhammarberg1v@qq.com",
        "password": "OHPToW17"
      },
      {
        "firstName": "Gabrila",
        "lastName": "Dauney",
        "email": "gdauney1w@usda.gov",
        "password": "tbLygSoQJV6"
      },
      {
        "firstName": "Con",
        "lastName": "Fludder",
        "email": "cfludder1x@apple.com",
        "password": "EyIEkR8k"
      },
      {
        "firstName": "Edna",
        "lastName": "Grayland",
        "email": "egrayland1y@businessweek.com",
        "password": "zSLiX1cZiO"
      },
      {
        "firstName": "Culver",
        "lastName": "Cridland",
        "email": "ccridland1z@yandex.ru",
        "password": "JES0DOM8joU"
      },
      {
        "firstName": "Omar",
        "lastName": "Morrice",
        "email": "omorrice20@hexun.com",
        "password": "Oj75UkNvnyTY"
      },
      {
        "firstName": "Theodor",
        "lastName": "Schollick",
        "email": "tschollick21@bbc.co.uk",
        "password": "Dd7XVvG1Znyl"
      },
      {
        "firstName": "Hodge",
        "lastName": "Espino",
        "email": "hespino22@bing.com",
        "password": "aI44Y2b0q5g"
      },
      {
        "firstName": "Nariko",
        "lastName": "Glascott",
        "email": "nglascott23@nymag.com",
        "password": "vkuoJbvbmI"
      },
      {
        "firstName": "Laurens",
        "lastName": "Thunnercliffe",
        "email": "lthunnercliffe24@home.pl",
        "password": "MOIjXLmX"
      },
      {
        "firstName": "Corry",
        "lastName": "Ilchuk",
        "email": "cilchuk25@people.com.cn",
        "password": "AbLBiolcaa9"
      },
      {
        "firstName": "Shanta",
        "lastName": "Couve",
        "email": "scouve26@ameblo.jp",
        "password": "AETQamIPv6S"
      },
      {
        "firstName": "Web",
        "lastName": "Oldknowe",
        "email": "woldknowe27@amazonaws.com",
        "password": "Eul1Zi"
      },
      {
        "firstName": "Nollie",
        "lastName": "Osgerby",
        "email": "nosgerby28@netscape.com",
        "password": "xPiOhoFny"
      },
      {
        "firstName": "Cherish",
        "lastName": "Brun",
        "email": "cbrun29@weather.com",
        "password": "pE6jf5FX"
      },
      {
        "firstName": "Zola",
        "lastName": "Cranch",
        "email": "zcranch2a@geocities.com",
        "password": "klxMA2Av"
      },
      {
        "firstName": "Chancey",
        "lastName": "McLachlan",
        "email": "cmclachlan2b@alibaba.com",
        "password": "97OCtb"
      },
      {
        "firstName": "Candida",
        "lastName": "Denyukin",
        "email": "cdenyukin2c@whitehouse.gov",
        "password": "SZisut02"
      },
      {
        "firstName": "Aubine",
        "lastName": "Iredale",
        "email": "airedale2d@macromedia.com",
        "password": "FpdGnpnpX"
      },
      {
        "firstName": "Lindi",
        "lastName": "Mazzeo",
        "email": "lmazzeo2e@census.gov",
        "password": "jAQs6mmW"
      },
      {
        "firstName": "Mollie",
        "lastName": "Elletson",
        "email": "melletson2f@msu.edu",
        "password": "OBtU3nguW"
      },
      {
        "firstName": "Kalindi",
        "lastName": "Londer",
        "email": "klonder2g@tmall.com",
        "password": "oRaKWF"
      },
      {
        "firstName": "Jilly",
        "lastName": "Llewhellin",
        "email": "jllewhellin2h@auda.org.au",
        "password": "fP9i9fxp"
      },
      {
        "firstName": "Patsy",
        "lastName": "Biaggioni",
        "email": "pbiaggioni2i@theglobeandmail.com",
        "password": "dZOECogF"
      },
      {
        "firstName": "Crissy",
        "lastName": "Pauwel",
        "email": "cpauwel2j@google.fr",
        "password": "Ga76j4pM"
      },
      {
        "firstName": "Annabela",
        "lastName": "Cheesworth",
        "email": "acheesworth2k@nyu.edu",
        "password": "A3fYGyL03C"
      },
      {
        "firstName": "Mercie",
        "lastName": "Borghese",
        "email": "mborghese2l@geocities.com",
        "password": "NHj2dg"
      },
      {
        "firstName": "Hana",
        "lastName": "Damato",
        "email": "hdamato2m@skyrock.com",
        "password": "NMkqp8"
      },
      {
        "firstName": "Chelsey",
        "lastName": "Tallman",
        "email": "ctallman2n@hc360.com",
        "password": "RPbMoKBkljI6"
      },
      {
        "firstName": "Wit",
        "lastName": "Benedek",
        "email": "wbenedek2o@amazon.com",
        "password": "ExWITMrn8AXD"
      },
      {
        "firstName": "Marleen",
        "lastName": "Burgwin",
        "email": "mburgwin2p@cnn.com",
        "password": "z1B8NWiJmR"
      },
      {
        "firstName": "Miller",
        "lastName": "Sydney",
        "email": "msydney2q@omniture.com",
        "password": "inkFBb1FAT"
      },
      {
        "firstName": "Lorelei",
        "lastName": "Endon",
        "email": "lendon2r@squarespace.com",
        "password": "DLxWHxnHE"
      }
    ]
    """
    
    let jsonData = json.data(using: .utf8)!
    let users = try! JSONDecoder().decode([User.CSVCreateContext].self, from: jsonData)
    return users
}
