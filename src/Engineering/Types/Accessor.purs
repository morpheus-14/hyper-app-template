module Engineering.Types.Accessor where

import Prelude

import Data.Lens (Lens', lens)
import Data.Newtype (class Newtype, unwrap, wrap)

_encryptKey :: forall a b c. Newtype a {encryptKey :: c | b} => Lens' a c
_encryptKey = lens (unwrap >>> _.encryptKey) (\oldRec newVal -> wrap ((unwrap oldRec) {encryptKey = newVal}))

_uri :: forall a b c. Newtype a {uri :: c | b} => Lens' a c
_uri = lens (unwrap >>> _.uri) (\oldRec newVal -> wrap ((unwrap oldRec) {uri = newVal}))

_viewId :: forall a b c. Newtype a {viewId :: c | b} => Lens' a c
_viewId = lens (unwrap >>> _.viewId) (\oldRec newVal -> wrap ((unwrap oldRec) {viewId = newVal}))

_name :: forall a b c. Newtype a {name :: c | b} => Lens' a c
_name = lens (unwrap >>> _.name) (\oldRec newVal -> wrap ((unwrap oldRec) {name = newVal}))

_bankName :: forall a b c. Newtype a {bankName :: c | b} => Lens' a c
_bankName = lens (unwrap >>> _.bankName) (\oldRec newVal -> wrap ((unwrap oldRec) {bankName = newVal}))

_payerInfo :: forall a b c. Newtype a {payerInfo :: c | b} => Lens' a c
_payerInfo = lens (unwrap >>> _.payerInfo) (\oldRec newVal -> wrap ((unwrap oldRec) {payerInfo = newVal}))

_customer :: forall a b c. Newtype a {customer :: c | b} => Lens' a c
_customer = lens (unwrap >>> _.customer) (\oldRec newVal -> wrap ((unwrap oldRec) {customer = newVal}))


_bankCode :: forall a b c. Newtype a {bankCode :: c | b} => Lens' a c
_bankCode = lens (unwrap >>> _.bankCode) (\oldRec newVal -> wrap ((unwrap oldRec) {bankCode = newVal}))

_default :: forall a b c. Newtype a {default :: c | b} => Lens' a c
_default = lens (unwrap >>> _.default) (\oldRec newVal -> wrap ((unwrap oldRec) {default = newVal}))

_passcodeSet :: forall a b c. Newtype a {passcodeSet :: c | b} => Lens' a c
_passcodeSet = lens (unwrap >>> _.passcodeSet) (\oldRec newVal -> wrap ((unwrap oldRec) {passcodeSet = newVal}))

_accountExists :: forall a b c. Newtype a {accountExists :: c | b} => Lens' a c
_accountExists = lens (unwrap >>> _.accountExists) (\oldRec newVal -> wrap ((unwrap oldRec) {accountExists = newVal}))

_content :: forall a b c. Newtype a {content :: c | b} => Lens' a c
_content = lens (unwrap >>> _.content) (\oldRec newVal -> wrap ((unwrap oldRec) {content = newVal}))

_regToken :: forall a b c. Newtype a {regToken :: c | b} => Lens' a c
_regToken = lens (unwrap >>> _.regToken) (\oldRec newVal -> wrap ((unwrap oldRec) {regToken = newVal}))

_loginToken :: forall a b c. Newtype a {loginToken :: c | b} => Lens' a c
_loginToken = lens (unwrap >>> _.loginToken) (\oldRec newVal -> wrap ((unwrap oldRec) {loginToken = newVal}))

_token :: forall a b c. Newtype a {token :: c | b} => Lens' a c
_token = lens (unwrap >>> _.token) (\oldRec newVal -> wrap ((unwrap oldRec) {token = newVal}))

_expiresIn :: forall a b c. Newtype a {expiresIn :: c | b} => Lens' a c
_expiresIn = lens (unwrap >>> _.expiresIn) (\oldRec newVal -> wrap ((unwrap oldRec) {expiresIn = newVal}))

_payToken :: forall a b c. Newtype a {payToken :: c | b} => Lens' a c
_payToken = lens (unwrap >>> _.payToken) (\oldRec newVal -> wrap ((unwrap oldRec) {payToken = newVal}))

_smsDetails :: forall a b c. Newtype a {smsDetails :: c | b} => Lens' a c
_smsDetails = lens (unwrap >>> _.smsDetails) (\oldRec newVal -> wrap ((unwrap oldRec) {smsDetails = newVal}))

_payTokenExpiredAt :: forall a b c. Newtype a {payTokenExpiredAt :: c | b} => Lens' a c
_payTokenExpiredAt = lens (unwrap >>> _.payTokenExpiredAt) (\oldRec newVal -> wrap ((unwrap oldRec) {payTokenExpiredAt = newVal}))

_mobileNumber :: forall a b c. Newtype a {mobileNumber :: c | b} => Lens' a c
_mobileNumber = lens (unwrap >>> _.mobileNumber) (\oldRec newVal -> wrap ((unwrap oldRec) {mobileNumber = newVal}))

_verified :: forall a b c. Newtype a {verified :: c | b} => Lens' a c
_verified = lens (unwrap >>> _.verified) (\oldRec newVal -> wrap ((unwrap oldRec) {verified = newVal}))

_mpinSet :: forall a b c. Newtype a {mpinSet :: c | b} => Lens' a c
_mpinSet = lens (unwrap >>> _.mpinSet) (\oldRec newVal -> wrap ((unwrap oldRec) {mpinSet = newVal}))

_account :: forall a b c. Newtype a {account :: c | b} => Lens' a c
_account = lens (unwrap >>> _.account) (\oldRec newVal -> wrap ((unwrap oldRec) {account = newVal}))

_accountId :: forall a b c. Newtype a {accountId :: c | b} => Lens' a c
_accountId = lens (unwrap >>> _.accountId) (\oldRec newVal -> wrap ((unwrap oldRec) {accountId = newVal}))

_vpa :: forall a b c. Newtype a {vpa :: c | b} => Lens' a c
_vpa = lens (unwrap >>> _.vpa) (\oldRec newVal -> wrap ((unwrap oldRec) {vpa = newVal}))

_vpaId :: forall a b c. Newtype a {vpaId :: c | b} => Lens' a c
_vpaId = lens (unwrap >>> _.vpaId) (\oldRec newVal -> wrap ((unwrap oldRec) {vpaId = newVal}))

_VpaId :: forall a b c. Newtype a {"VpaId" :: c | b} => Lens' a c
_VpaId = lens (unwrap >>> _."VpaId") (\oldRec newVal -> wrap ((unwrap oldRec) {"VpaId" = newVal}))

_status :: forall a b c. Newtype a {status :: c | b} => Lens' a c
_status = lens (unwrap >>> _.status) (\oldRec newVal -> wrap ((unwrap oldRec) {status = newVal}))

_simSlot :: forall a b c. Newtype a {simSlot :: c | b} => Lens' a c
_simSlot = lens (unwrap >>> _.simSlot) (\oldRec newVal -> wrap ((unwrap oldRec) {simSlot = newVal}))

_amount :: forall a b c. Newtype a {amount :: c | b} => Lens' a c
_amount = lens (unwrap >>> _.amount) (\oldRec newVal -> wrap ((unwrap oldRec) {amount = newVal}))

_payeeVpa :: forall a b c. Newtype a {payeeVpa :: c | b} => Lens' a c
_payeeVpa = lens (unwrap >>> _.payeeVpa) (\oldRec newVal -> wrap ((unwrap oldRec) {payeeVpa = newVal}))

_payerVpa :: forall a b c. Newtype a {payerVpa :: c | b} => Lens' a c
_payerVpa = lens (unwrap >>> _.payerVpa) (\oldRec newVal -> wrap ((unwrap oldRec) {payerVpa = newVal}))


_remarks :: forall a b c. Newtype a {remarks :: c | b} => Lens' a c
_remarks = lens (unwrap >>> _.remarks) (\oldRec newVal -> wrap ((unwrap oldRec) {remarks = newVal}))

_upiRequestId :: forall a b c. Newtype a {upiRequestId :: c | b} => Lens' a c
_upiRequestId = lens (unwrap >>> _.upiRequestId) (\oldRec newVal -> wrap ((unwrap oldRec) {upiRequestId = newVal}))

_contactType :: forall a b c. Newtype a {contactType :: c | b} => Lens' a c
_contactType = lens (unwrap >>> _.contactType) (\oldRec newVal -> wrap ((unwrap oldRec) {contactType = newVal}))

_aadharNumber :: forall a b c. Newtype a {aadharNumber :: c | b} => Lens' a c
_aadharNumber = lens (unwrap >>> _.aadharNumber) (\oldRec newVal -> wrap ((unwrap oldRec) {aadharNumber = newVal}))

_ifsc :: forall a b c. Newtype a {ifsc :: c | b} => Lens' a c
_ifsc = lens (unwrap >>> _.ifsc) (\oldRec newVal -> wrap ((unwrap oldRec) {ifsc = newVal}))

_nickName :: forall a b c. Newtype a {nickName :: c | b} => Lens' a c
_nickName = lens (unwrap >>> _.nickName) (\oldRec newVal -> wrap ((unwrap oldRec) {nickName = newVal}))

_registeredName :: forall a b c. Newtype a {registeredName :: c | b} => Lens' a c
_registeredName = lens (unwrap >>> _.registeredName) (\oldRec newVal -> wrap ((unwrap oldRec) {registeredName = newVal}))

_beneficiaryData :: forall a b c. Newtype a {beneficiaryData :: c | b} => Lens' a c
_beneficiaryData = lens (unwrap >>> _.beneficiaryData) (\oldRec newVal -> wrap ((unwrap oldRec) {beneficiaryData = newVal}))

_transactionData :: forall a b c. Newtype a {transactionData :: c | b} => Lens' a c
_transactionData = lens (unwrap >>> _.transactionData) (\oldRec newVal -> wrap ((unwrap oldRec) {transactionData = newVal}))

_txnInfo :: forall a b c. Newtype a {txnInfo :: c | b} => Lens' a c
_txnInfo = lens (unwrap >>> _.txnInfo) (\oldRec newVal -> wrap ((unwrap oldRec) {txnInfo = newVal}))

_mam :: forall a b c. Newtype a {mam :: c | b} => Lens' a c
_mam = lens (unwrap >>> _.mam) (\oldRec newVal -> wrap ((unwrap oldRec) {mam = newVal}))

_id :: forall a b c. Newtype a {id :: c | b} => Lens' a c
_id = lens (unwrap >>> _.id) (\oldRec newVal -> wrap ((unwrap oldRec) {id = newVal}))

_isVisible :: forall a b c. Newtype a {isVisible :: c | b} => Lens' a c
_isVisible = lens (unwrap >>> _.isVisible) (\oldRec newVal -> wrap ((unwrap oldRec) {isVisible = newVal}))

_expiry :: forall a b c. Newtype a {expiry :: c | b} => Lens' a c
_expiry = lens (unwrap >>> _.expiry) (\oldRec newVal -> wrap ((unwrap oldRec) {expiry = newVal}))

_createContact :: forall a b c. Newtype a {createContact :: c | b} => Lens' a c
_createContact = lens (unwrap >>> _.createContact) (\oldRec newVal -> wrap ((unwrap oldRec) {createContact = newVal}))

_payeeInfo :: forall a b c. Newtype a {payeeInfo :: c | b} => Lens' a c
_payeeInfo = lens (unwrap >>> _.payeeInfo) (\oldRec newVal -> wrap ((unwrap oldRec) {payeeInfo = newVal}))

_type :: forall a b c. Newtype a {type :: c | b} => Lens' a c
_type = lens (unwrap >>> _.type) (\oldRec newVal -> wrap ((unwrap oldRec) {type = newVal}))

_pa :: forall a b c. Newtype a {pa :: c | b} => Lens' a c
_pa = lens (unwrap >>> _.pa) (\oldRec newVal -> wrap ((unwrap oldRec) {pa = newVal}))

_pn :: forall a b c. Newtype a {pn :: c | b} => Lens' a c
_pn = lens (unwrap >>> _.pn) (\oldRec newVal -> wrap ((unwrap oldRec) {pn = newVal}))

_registrationToken :: forall a b c. Newtype a {registrationToken :: c | b} => Lens' a c
_registrationToken = lens (unwrap >>> _.registrationToken) (\oldRec newVal -> wrap ((unwrap oldRec) {registrationToken = newVal}))

_banks :: forall a b c. Newtype a {banks :: c | b} => Lens' a c
_banks = lens (unwrap >>> _.banks) (\oldRec newVal -> wrap ((unwrap oldRec) {banks = newVal}))

_accounts :: forall a b c. Newtype a {accounts :: c | b} => Lens' a c
_accounts = lens (unwrap >>> _.accounts) (\oldRec newVal -> wrap ((unwrap oldRec) {accounts = newVal}))

_contacts :: forall a b c. Newtype a {contacts :: c | b} => Lens' a c
_contacts = lens (unwrap >>> _.contacts) (\oldRec newVal -> wrap ((unwrap oldRec) {contacts = newVal}))

_transactions :: forall a b c. Newtype a {transactions :: c | b} => Lens' a c
_transactions = lens (unwrap >>> _.transactions) (\oldRec newVal -> wrap ((unwrap oldRec) {transactions = newVal}))

_offers :: forall a b c. Newtype a {offers :: c | b} => Lens' a c
_offers = lens (unwrap >>> _.offers) (\oldRec newVal -> wrap ((unwrap oldRec) {offers = newVal}))

_transaction :: forall a b c. Newtype a {transaction :: c | b} => Lens' a c
_transaction = lens (unwrap >>> _.transaction) (\oldRec newVal -> wrap ((unwrap oldRec) {transaction = newVal}))

_queries :: forall a b c. Newtype a {queries :: c | b} => Lens' a c
_queries = lens (unwrap >>> _.queries) (\oldRec newVal -> wrap ((unwrap oldRec) {queries = newVal}))

_rewards :: forall a b c. Newtype a {rewards :: c | b} => Lens' a c
_rewards = lens (unwrap >>> _.rewards) (\oldRec newVal -> wrap ((unwrap oldRec) {rewards = newVal}))

_data :: forall a b c. Newtype a {data :: c | b} => Lens' a c
_data = lens (unwrap >>> _.data) (\oldRec newVal -> wrap ((unwrap oldRec) {data = newVal}))

_query :: forall a b c. Newtype a {query :: c | b} => Lens' a c
_query = lens (unwrap >>> _.query) (\oldRec newVal -> wrap ((unwrap oldRec) {query = newVal}))

_otp :: forall a b c. Newtype a {otp :: c | b} => Lens' a c
_otp = lens (unwrap >>> _.otp) (\oldRec newVal -> wrap ((unwrap oldRec) {otp = newVal}))

_generationStatus :: forall a b c. Newtype a {generationStatus :: c | b} => Lens' a c
_generationStatus = lens (unwrap >>> _.generationStatus) (\oldRec newVal -> wrap ((unwrap oldRec) {generationStatus = newVal}))

_error :: forall a b c. Newtype a {error :: c | b} => Lens' a c
_error = lens (unwrap >>> _.error) (\oldRec newVal -> wrap ((unwrap oldRec) {error = newVal}))

_requested :: forall a b c. Newtype a {requested :: c | b} => Lens' a c
_requested = lens (unwrap >>> _.requested) (\oldRec newVal -> wrap ((unwrap oldRec) {requested = newVal}))

_reversed :: forall a b c. Newtype a {reversed :: c | b} => Lens' a c
_reversed = lens (unwrap >>> _.reversed) (\oldRec newVal -> wrap ((unwrap oldRec) {reversed = newVal}))

