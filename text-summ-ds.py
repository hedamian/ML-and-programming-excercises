# https://pub.towardsai.net/a-full-introduction-on-text-summarization-using-deep-learning-with-sample-code-ft-huggingface-d21e0336f50c
from transformers import BartTokenizer, BartForConditionalGeneration, BartConfig
#from transformers.modeling_tf_bert import TFBertForSequenceClassification
#from transformers import TFBertForSequenceClassification
import torch

model = BartForConditionalGeneration.from_pretrained('facebook/bart-large-cnn')
tokenizer = BartTokenizer.from_pretrained('facebook/bart-large-cnn')
ARTICLE_TO_SUMMARIZE = """sebastian vettel is determined to ensure the return of a long-standing ritual at ferrari is not a one-off this season. fresh from ferrari's first victory in 35 grands prix in malaysia 11 days ago, and ending his own 20-race drought, vettel returned to a hero's welcome at the team's factory at maranello last week. the win allowed ferrari to revive a tradition not seen at their base for almost two years since their previous triumph in may 2013 at the spanish grand prix courtesy of fernando alonso. sebastian vettel reflected on his stunning win for ferrari at the malaysian grand prix during the press conference before the weekend's chinese grand prix in shanghai the four-time world champion shares a friendly discussion with mclaren star jenson button four-times world champion vettel said: 'it was a great victory we had in malaysia, great for us as a team, and for myself a very emotional day - my first win with ferrari. 'when i returned to the factory on wednesday, to see all the people there was quite special. there are a lot of people working there and as you can imagine they were very, very happy. 'the team hadn't won for quite a while, so they enjoyed the fact they had something to celebrate. there were a couple of rituals involved, so it was nice for them to get that feeling again.' asked as to the specific nature of the rituals, vettel replied: 'i was supposed to be there for simulator work anyway, but it was quite nice to receive the welcome after the win. ferrari's vettel and britta roeske arrive at the shanghai circuit along with a ferrari mechanic, vettel caught up with members of his old team red bull on thursday 'all the factory got together for a quick lunch. it was quite nice to have all the people together in one room - it was a big room! - so we were able to celebrate altogether for a bit. 'i also learned when you win with ferrari, at the entry gate, they raise a ferrari flag - and obviously it's been a long time since they last did that. 'some 10 years ago there were a lot of flags, especially at the end of a season, so this flag will stay there for the rest of the year. 'we will, of course, try and put up another one sometime soon.' inside the ferrari garage, vettel shares a discussion with team staff as he looks to build on his sepang win ferrari team principal maurizio arrivabene shares a conversation with vettel at the team's hospitality suite the feeling is that will not happen after this weekend's race in china as the conditions at the shanghai international circuit are expected to suit rivals mercedes. not that vettel believes his success will be a one-off, adding: 'for here and the next races, we should be able to confirm we have a strong package and a strong car. 'we will want to make sure we stay ahead of the people we were ahead of in the first couple of races, but obviously knowing mercedes are in a very, very strong position. 'in general, for the start of a season things can be up and down, and we want to make sure there is quite a lot of ups, not so many downs. 'but it's normal in some races you are more competitive than others. 'we managed to do a very good job in malaysia, but for here and the next races we have to be realistic about we want to achieve.' ferrari mechanics show their joy after vettel won the malaysian grand prix, helping record the team's first formula one win since 2013 at the spanish grand prix"""


the_encoder = model.get_encoder()
the_decoder = model.get_decoder()
last_linear_layer = model.lm_head


tokenized_input = tokenizer([ARTICLE_TO_SUMMARIZE], max_length=1024, truncation=True, return_tensors='pt')
#print(model)

input_representation = the_encoder(input_ids = tokenized_input.input_ids,
                                   attention_mask = tokenized_input.attention_mask)

start_token = torch.tensor( [tokenizer.bos_token_id] ).unsqueeze(0)
mask_ids    = torch.tensor( [1] ).unsqueeze(0)

decoder_output = the_decoder(input_ids=start_token,
                             attention_mask=mask_ids,
                             encoder_hidden_states=input_representation[0],
                             encoder_attention_mask=tokenized_input.attention_mask )
decoder_output = decoder_output.last_hidden_state

logits = last_linear_layer(decoder_output[0])
predicted_token = logits.argmax(1)
 #print(predicted_token) => 1090
# print(tokenizer.convert_ids_to_tokens(predicted_token)) => 'se'

tokenizer.convert_ids_to_tokens(predicted_token)

summary_ids = model.generate(tokenized_input['input_ids'], max_length=15, early_stopping=True)
print([tokenizer.decode(g, skip_special_tokens=True, clean_up_tokenization_spaces=False) for g in summary_ids])


tokenizer.convert_ids_to_tokens( summary_ids[0] )


summary_ids

