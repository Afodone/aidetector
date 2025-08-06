//
//  AIDSampleData.swift
//  AIDetector
//
//  Created by yong on 2025/8/1.
//

import Foundation

struct AIDSampleData{
    let name:String
    let title:String
    
    
    static let datas:[AIDSampleData] = simples.map { name in
            .init(name: name, title: "")
    }
    
    static let simples = [
        "Bright sunshine expected today with highs around 78°F. A gentle breeze from the west. Perfect weather for picnics or hiking. Grab your sunglasses and enjoy the beautiful day! Low humidity makes it feel very comfortable.",
        
        "City council approved funding for the new community center yesterday. Construction begins next month, creating 50 local jobs. The center will feature a gym, library, and childcare facilities. Residents celebrated the decision.",
        
        "The old key felt heavy in her pocket. She climbed the creaky stairs to the attic, heart pounding. Dust motes danced in the sunlight. What secret did Grandma's locked trunk hold? She took a deep breath.",
        
        "Hi Team, Just a reminder: the Q3 budget review meeting is scheduled for tomorrow at 10 AM in Conference Room B. Please bring your finalized reports. Looking forward to our discussion. Best regards, Sarah.",
        
        "Thursday: Exhausted but satisfied. Finished the big presentation – it went well! Treated myself to pizza. Watched a silly movie to unwind. Need an early night. Hoping for rain tomorrow; love the sound.",
        
        "Heavy rain warning in effect until 6 PM. Expect localized flooding on low-lying roads. Strong winds may cause minor power outages. Stay indoors if possible. Carry an umbrella and drive cautiously if you must go out.",
        
        
        "Tech giant 'Nova' unveiled its new AI assistant yesterday. It promises more natural conversations and better task automation than competitors. Beta testing starts next week. Privacy advocates have raised immediate concerns about data collection.",
        
        "He found the lost puppy shivering under the porch during the storm. Its big brown eyes looked scared. Wrapping it in his coat, he whispered, \"Don't worry, little guy. You're safe now.\" Home felt warmer.",
        
        "Hey Mark! Are you free for lunch next Tuesday? That new sushi place downtown finally opened – want to try it? Let me know what time works. Hope you're having a good week! Cheers, Lisa.",
        
        
        "Feeling a bit restless today. Walked through the park, saw ducks on the pond. Bought that blue sweater I'd been eyeing. Called Mom. Still thinking about that strange dream last night. Early to bed.",
        
        "Patchy fog this morning, clearing by 10 AM. Turning partly cloudy with a high near 65°F. Cooler by the lake. A slight chance of a shower late afternoon, but most areas will stay dry.",
        
        "Underdog Riverdale High stunned champions Westfield last night, winning the state basketball finals 68-65 in overtime! Star player J. Davis scored the winning basket with only 2 seconds left. Crowd went wild.",
        
        "The map was faded, the 'X' barely visible. They dug carefully where the old oak's shadow fell at noon. The spade hit something solid. Could pirate gold really be buried in their backyard?",
        
        "Dear Mr. Evans, This is a friendly reminder that your dental check-up is scheduled for tomorrow, March 12th, at 3:30 PM. Please arrive 10 minutes early. Call us if you need to reschedule. Sincerely, Oakwood Dental.",
        
        
        "Weekend! Slept in, glorious. Finally planted the herbs: basil, mint, rosemary. Hope they survive me. Met Tom for coffee downtown. Laughed a lot. Reading a mystery novel now. Rain tapping on the window is soothing.",
        
        "Heatwave alert! Temperatures soaring to 98°F today and tomorrow. Extreme heat index over 105°F. Stay hydrated, limit outdoor activity, and check on elderly neighbors. Cooling centers are open in the city library and community hall.",
        
        "Volunteers collected over 2 tons of trash from Coastal Beach during the annual cleanup. Plastic bottles and packaging were the most common items found. Organizers urge reduced plastic use to protect marine life.",
        
        "The music box played a faint, haunting tune she hadn't heard since childhood. Opening it revealed a tiny, faded photograph of her mother, smiling. Tears welled up. Some memories are treasures.",
        
        
        "Hi Priya, So sorry I missed our call this morning! My alarm didn't go off, and I overslept terribly. Completely my fault. Can we reschedule for tomorrow afternoon? Let me know what works. Apologies again, Ben.",
        
        "Frustrating day at work. Computer crashed twice, lost some progress. Traffic jam coming home. Ordered takeout Thai food – pad thai fixes most things. Watching cat videos online now. Simple pleasures. Tomorrow will be better.",
        
        
        "Cold snap incoming! Temperatures dropping rapidly tonight. Expect lows near 20°F with wind chill making it feel like 10°F. Protect pipes, bring pets inside, and bundle up if heading out. Frost likely by morning.",
        
        
        "Local artist Mia Chen won the National Portrait Prize for her stunning painting 'Reflections'. The piece explores identity and family heritage. Her exhibition opens at the City Gallery next Friday.",
        
        "The message in the bottle was waterlogged, but legible: 'Help! Stranded on island. North of reef. Tell Marie I love her.' He grabbed his binoculars, scanning the horizon urgently.",
        
        "Dear Mrs. Henderson, Thank you so much for the lovely birthday gift! The scarf is beautiful and just my style. It was so thoughtful of you to remember. Warm regards, Emily.",
        
        "Tried baking sourdough bread for the first time. Kitchen looks like a flour bomb went off! The loaf is... dense. Let's call it 'rustic'. Tastes okay with enough butter. Practice needed! ",
        
        "Beautiful autumn day! Crisp air, bright sunshine, and vibrant fall colors. High near 60°F. Perfect for apple picking or a long walk in the woods. Enjoy the seasonal beauty while it lasts!",
        
        "Researchers announced a potential breakthrough in battery technology. New material promises faster charging and longer lifespan for phones and electric cars. Lab tests successful; real-world trials begin next year.",
        
        "The last cookie sat on the plate. Brother and sister stared at it. 'Rock, paper, scissors?' she suggested. He nodded. Best two out of three decides who gets the chocolate chip prize.",
        
        "You're invited! Join us for a housewarming party on Saturday, October 21st, from 4-7 PM. 123 Maple Street. BBQ, drinks, and good company! RSVP by the 15th. Hope you can make it! - The Parkers.",
        
        "Feeling productive! Cleaned the garage finally – found my old rollerblades! Donated three bags of stuff. Feels good to declutter. Made a big pot of vegetable soup. Simple, quiet, satisfying Sunday.",
        
        "Breezy and mild today, with increasing clouds. A 40% chance of scattered showers developing late this afternoon, mainly south of the city. High around 72°F. Keep an umbrella handy just in case.",
        
        "Local bookstore 'Pages & Paws' thrives despite online giants, thanks to community support and hosting author events. They even have a resident cat! Sales up 15% this year. A neighborhood success story.",
        
        "She whispered the ancient words, fingers tracing the symbols on the stone. A soft glow emanated, then faded. Nothing happened. Or did it? A subtle warmth lingered in the air around her.",
        
        "Hi Dave, Tks for the notes. I incorporated your edits – file attached. Let me know if this looks good before I send it to the client. Appreciate your quick review! Tks, Chloe.",
        
        "Long phone call with Alex today. Good to catch up properly. He's moving back next month! Feeling nostalgic about old times. Also slightly worried about work deadlines piling up. Need to focus tomorrow.",
        
        "Dense fog advisory until 9 AM. Visibility less than a quarter mile in some areas. Drive slowly, use low beams, and allow extra travel time. Fog will lift to reveal a sunny, warm day later.",
        
        "Free flu shots available at all community health centers this Saturday, October 28th, from 9 AM to 1 PM. No appointment needed. Health officials urge vaccination ahead of the expected winter flu season.",
        
        "The tiny seedling pushed through the crack in the concrete. Against all odds, it found the sunlight. He watered it carefully. A small green sign of hope in the grey city.",
        
        "Thank you for your email. I am out of the office on vacation with limited access until Monday, November 6th. For urgent matters, please contact support@company.com. I will respond upon my return. Best regards, Michael.",
        
        "Woke up with a song stuck in my head. Couldn't place it all day! Drove me nuts. Finally remembered – it was from that old cereal commercial! Brains are weird. Made banana bread.",
        
        
        "Unsettled weather continues. Periods of rain, heavy at times, mixed with sunny breaks. Chance of a rumble of thunder. High near 68°F. Keep rain gear close; conditions change rapidly throughout the day.",
        
        "New direct flight route announced between Springfield and Miami starting December 1st. Flights operate three times weekly. Early bird fares available now. Great news for winter sun seekers!",
        
        
        "He dropped the last coin into the old jukebox. The opening chords filled the empty diner. She turned, surprised, remembering their song. A hesitant smile touched her lips across the worn counter.",
        
        "Hi Jenna, Could we schedule 30 minutes sometime Thursday or Friday to discuss the upcoming project timeline? My calendar is flexible in the afternoons. Please suggest a time that works for you. Thanks, David.",
        
        
        "Visited the botanical gardens. So peaceful. Amazing orchids! Took tons of photos. Sat by the koi pond for ages, just breathing. Felt recharged. Need to do this more often. Nature is the best therapy.",
        
        
        "Clear and cold tonight! Excellent stargazing conditions. Bundle up if heading out. Low near 25°F. Patchy ice possible on untreated surfaces by morning. A bright, frosty sunrise expected tomorrow.",
        
        "Lincoln Elementary wins national 'Green School' award for its solar panels, recycling program, and student-run vegetable garden. Kids learn sustainability hands-on. The prize includes funds for more eco-projects. Congratulations!",
        
        "The final puzzle piece clicked into place. She leaned back, surveying the completed picture – a thousand tiny fragments forming a majestic castle. A small victory, but hers alone.",
        
        "Hi Carlos, Just heard the fantastic news about your promotion! Huge congratulations! Well deserved – your hard work really paid off. Wishing you all the best in the new role. Cheers, Anya.",
        
        "Full moon tonight. Looks huge! Walked the dog under its glow, everything silver and shadow. Feeling strangely energized, maybe restless? Brewing tea now. Need to wind down. Good vibes for tomorrow."
        
        
        
    ]


   
}
