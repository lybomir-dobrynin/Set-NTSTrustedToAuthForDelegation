Функция принимает массив имен серверов, для которых необходимо настроить перекрестное TrustedToAuthForDelegation, что необходимо при миграции между Hyper-V хостами

Пример: `Set-NTSTrustedToAuthForDelegation -Servers "hv1","hv2","hv3"`