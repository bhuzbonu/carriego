alter procedure ListShipmentDetails
	@trackingNumber	NVARCHAR(200)
AS
BEGIN
	select 
			p.TrackingNumber	as	trackingNumber,
			p.SerialNumber		as	serialNumber,
			p.Height			as	packageHeight,
			p.Length			as	packageLength,
			p.Depth				as	packageDepth,
			p.DimensionUOM		as	dimensionUOM,
			p.TotalWeight		as	totalWeight,
			ISNULL(p.MeasuredWeight, 0)	as	measuredWeight,
			p.NetWeight			as	netWeight,
			p.WeightUOM			as	weightUOM,

			s.ShipmentNumber	as	shipmentNumber,
			FORMAT (s.CreationDate, 'd', 'en-US' )		as	creationDate,
			ss.Name				as	shipmentStatus,
			sl.DisplayName		as	serviceLevel,
			c.Name				as	carrier,

			shipTo.Name			as	shipToName,
			shipTo.Address		as	shipToAddress,
			shipTo.City			as	shipToCity,
			shipTo.CountryCode	as	shipToCountry,
			
			sender.Name			as	senderName,
			sender.Address		as	senderAddress,
			sender.City			as	senderCity,
			sender.CountryCode	as	senderCountry
	FROM	Package			p
	JOIN	Shipment		s		ON	p.ShipmentId		=	s.Id
	JOIN	ShipmentStatus	ss		ON	ss.Id				=	s.ShipmentStatusId
	JOIN	ServiceLevel	sl		ON	s.ServiceLevelId	=	sl.Id
	JOIN	Carrier			c		ON	sl.CarrierId		=	c.Id
	JOIN	Address			shipTo	ON	s.ShipToAddressId	=	shipTo.Id
	JOIN	Address			sender	ON	s.SenderAddressId	=	sender.Id
	WHERE	p.TrackingNumber = @trackingNumber
END

/*

EXEC dbo.ListShipmentDetails '794655748180'

*/